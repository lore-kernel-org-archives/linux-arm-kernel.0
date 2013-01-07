From: simon.guinot@sequanux.org (Simon Guinot)
Date: Mon, 7 Jan 2013 16:11:38 +0100
Subject: [PATCH 01/11] ARM: Kirkwood: Fix missing clk for USB device.
In-Reply-To: <1357467044-4914-2-git-send-email-andrew@lunn.ch>
References: <1357467044-4914-1-git-send-email-andrew@lunn.ch>
 <1357467044-4914-2-git-send-email-andrew@lunn.ch>
Message-ID: <20130107151138.GJ1357@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 06, 2013 at 11:10:34AM +0100, Andrew Lunn wrote:
> Without the clock being held by a driver, it gets turned off at a bad
> time causing the SoC to lockup. This is often during reboot.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Stefan Peter <s.peter@mpl.ch>
> ---
>  arch/arm/boot/dts/kirkwood.dtsi |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index 7735cee..110d6cb 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -144,6 +144,7 @@
>  			compatible = "marvell,orion-ehci";
>  			reg = <0x50000 0x1000>;
>  			interrupts = <19>;
> +			clocks = <&gate_clk 3>;
>  			status = "okay";
>  		};

Hi Andrew,

Maybe you also want to remove the clock alias workaround from
kirkwood_legacy_clk_init() ?

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130107/cb765a85/attachment.sig>
