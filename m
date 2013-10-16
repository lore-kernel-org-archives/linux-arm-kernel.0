From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 16 Oct 2013 18:47:08 +0530
Subject: [PATCH v2 2/2] ARM: dts: omap5: Add dr_mode for dwc3
In-Reply-To: <1381816199-7966-1-git-send-email-kishon@ti.com>
References: <52580F34.8030809@ti.com>
 <1381816199-7966-1-git-send-email-kishon@ti.com>
Message-ID: <525E91D4.30509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit,

On Tuesday 15 October 2013 11:19 AM, Kishon Vijay Abraham I wrote:
> From: George Cherian <george.cherian@ti.com>
> 
> Added dr_mode property in dwc3 and set its default mode to device.
> Currently dwc3 driver doesn't have support for OTG mode. So explicitly
> setting to peripheral even dwc3 is a OTG controller since OMAP5 has
> already got an EHCI host.
> 
> Signed-off-by: George Cherian <george.cherian@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Can you take this patch for 3.13?

Thanks
Kishon
> ---
> Changes from v1:
> Changed the commit log to explain why dr_mode was not set to OTG.
>  arch/arm/boot/dts/omap5.dtsi |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 6d0a1d5..ef598af 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -652,6 +652,7 @@
>  				reg = <0x4a030000 0x10000>;
>  				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
>  				usb-phy = <&usb2_phy>, <&usb3_phy>;
> +				dr_mode = "peripheral";
>  				tx-fifo-resize;
>  			};
>  		};
> 
