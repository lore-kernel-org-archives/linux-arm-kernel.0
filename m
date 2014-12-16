From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 16 Dec 2014 09:19:22 +0100
Subject: [PATCH 1/2] ARM: dts: kirkwood: enable phy driver for SATA
 controller on 88f6192
In-Reply-To: <20141215203724.GA22936@anne>
References: <20141215203724.GA22936@anne>
Message-ID: <20141216081922.GA1450@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 09:37:24PM +0100, Evgeni Dobrev wrote:
> This patch enables the phy drivers for the SATA controller on Marvell's 88f6192. Without them it is not possible to use SATA drives attached to this processor.
> 
> Signed-off-by: Evgeni Dobrev <evgeni@studio-punkt.com>

Acked-by: Andrew Lunn <andrew@lunn.ch>

This should also go to stable.

     Andrew


> ---
>  arch/arm/boot/dts/kirkwood-6192.dtsi |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-6192.dtsi b/arch/arm/boot/dts/kirkwood-6192.dtsi
> index dd81508..bed2dec 100644
> --- a/arch/arm/boot/dts/kirkwood-6192.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-6192.dtsi
> @@ -66,6 +66,8 @@
>  			interrupts = <21>;
>  			clocks = <&gate_clk 14>, <&gate_clk 15>;
>  			clock-names = "0", "1";
> +                        phys = <&sata_phy0>, <&sata_phy1>;
> +                        phy-names = "port0", "port1";
>  			status = "disabled";
>  		};
>  
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
