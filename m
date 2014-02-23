From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 23 Feb 2014 18:31:03 +0100
Subject: [PATCH 1/4] ARM: Kirkwood: Add audio node to kirkwood.dtsi
In-Reply-To: <1393175982-18516-2-git-send-email-andrew@lunn.ch>
References: <1393175982-18516-1-git-send-email-andrew@lunn.ch>
 <1393175982-18516-2-git-send-email-andrew@lunn.ch>
Message-ID: <20140223183103.36291758@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Sun, 23 Feb 2014 18:19:39 +0100, Andrew Lunn wrote:
> The binding has existed for a while, so add the missing node so it can
> be used by devices.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/kirkwood.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index 7b921b30cfcb..841ca3affbf5 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -310,5 +310,14 @@
>  			#phy-cells = <0>;
>  			status = "ok";
>  		};
> +
> +                audio0: audio-controller at a0000 {
> +			compatible = "marvell,kirkwood-audio";
> +                        reg = <0xa0000 0x2210>;
> +                        interrupts = <24>;
> +                        clocks = <&gate_clk 9>;
> +                        clock-names = "internal";
> +                        status = "disabled";

Bad indentation for all properties except the first one.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
