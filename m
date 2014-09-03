From: tony@atomide.com (Tony Lindgren)
Date: Wed, 3 Sep 2014 14:51:13 -0700
Subject: [PATCH] arm: boot: dts: am4372: fix USB regs size
In-Reply-To: <1409779344-27823-1-git-send-email-balbi@ti.com>
References: <1409779344-27823-1-git-send-email-balbi@ti.com>
Message-ID: <20140903215112.GP11766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [140903 14:28]:
> Size should be 64KiB instead of 92KiB.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/boot/dts/am4372.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index 9b3d2ba..8689949 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -804,7 +804,7 @@
>  
>  			usb1: usb at 48390000 {
>  				compatible = "synopsys,dwc3";
> -				reg = <0x48390000 0x17000>;
> +				reg = <0x48390000 0x10000>;
>  				interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
>  				phys = <&usb2_phy1>;
>  				phy-names = "usb2-phy";
> @@ -826,7 +826,7 @@
>  
>  			usb2: usb at 483d0000 {
>  				compatible = "synopsys,dwc3";
> -				reg = <0x483d0000 0x17000>;
> +				reg = <0x483d0000 0x10000>;
>  				interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
>  				phys = <&usb2_phy2>;
>  				phy-names = "usb2-phy";
> -- 

Applying into omap-for-v3.17/fixes-v2 thanks.

Tony
