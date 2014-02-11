From: rogerq@ti.com (Roger Quadros)
Date: Tue, 11 Feb 2014 15:53:19 +0200
Subject: [PATCH] ARM: dts: OMAP2+: Fix boot with multi_v7_defconfig
In-Reply-To: <1392055835-6494-1-git-send-email-rogerq@ti.com>
References: <1392055835-6494-1-git-send-email-rogerq@ti.com>
Message-ID: <52FA2B4F.3010408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2014 08:10 PM, Roger Quadros wrote:
> The OMAP EHCI controller is not compatible with the EHCI
> platform HCD driver so don't claim that we are.
> 
> This fixes boot on OMAP platforms with CONFIG_USB_EHCI_HCD_PLATFORM=y
> e.g. multi_v7_defconfig
> 
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Please ignore this patch as Hans has agreed to do a more proper fix in

http://article.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/7015

cheers,
-roger

> ---
>  arch/arm/boot/dts/omap3.dtsi | 2 +-
>  arch/arm/boot/dts/omap4.dtsi | 2 +-
>  arch/arm/boot/dts/omap5.dtsi | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index a5fc83b..6b5dbf8 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -641,7 +641,7 @@
>  			};
>  
>  			usbhsehci: ehci at 48064800 {
> -				compatible = "ti,ehci-omap", "usb-ehci";
> +				compatible = "ti,ehci-omap";
>  				reg = <0x48064800 0x400>;
>  				interrupt-parent = <&intc>;
>  				interrupts = <77>;
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index d3f8a6e..f5d754b 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -706,7 +706,7 @@
>  			};
>  
>  			usbhsehci: ehci at 4a064c00 {
> -				compatible = "ti,ehci-omap", "usb-ehci";
> +				compatible = "ti,ehci-omap";
>  				reg = <0x4a064c00 0x400>;
>  				interrupt-parent = <&gic>;
>  				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index a72813a..42fcffd 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -784,7 +784,7 @@
>  			};
>  
>  			usbhsehci: ehci at 4a064c00 {
> -				compatible = "ti,ehci-omap", "usb-ehci";
> +				compatible = "ti,ehci-omap";
>  				reg = <0x4a064c00 0x400>;
>  				interrupt-parent = <&gic>;
>  				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> 
