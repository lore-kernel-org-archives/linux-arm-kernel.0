From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 25 Mar 2013 09:47:39 +0100
Subject: [PATCHv2 4/4] arm: orion5x: correct IRQ used in dtsi for mv_cesa
In-Reply-To: <1364077797-21206-5-git-send-email-alex@digriz.org.uk>
References: <1364077797-21206-1-git-send-email-alex@digriz.org.uk>
 <1364077797-21206-5-git-send-email-alex@digriz.org.uk>
Message-ID: <20130325084739.GF5627@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 23, 2013 at 10:29:57PM +0000, Alexander Clouter wrote:
> The crypto functionality hook in the orion5x dtsi uses an IRQ that clashes
> with the Ethernet controller, so lets move it to use the IRQ that the non-DT
> code utilises.

Hi Alex

Move is the wrong word here. The IRQ are hardware assigned, you cannot
pick and choose. I would write a comment like:

Fix the IRQ number for crypto, which should be 28, not 22 which is
actually Ethernet.

	 Andrew


> 
> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
> ---
>  arch/arm/boot/dts/orion5x.dtsi |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
> index 3944b9b..f4be4c5 100644
> --- a/arch/arm/boot/dts/orion5x.dtsi
> +++ b/arch/arm/boot/dts/orion5x.dtsi
> @@ -127,7 +127,7 @@
>  			reg = <0x90000 0x10000>,
>  			      <0xf2200000 0x800>;
>  			reg-names = "regs", "sram";
> -			interrupts = <22>;
> +			interrupts = <28>;
>  			status = "okay";
>  		};
>  	};
> -- 
> 1.7.10.4
> 
