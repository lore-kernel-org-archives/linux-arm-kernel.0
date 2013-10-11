From: rogerq@ti.com (Roger Quadros)
Date: Fri, 11 Oct 2013 17:46:12 +0300
Subject: [PATCH 2/2] ARM: dts: omap5: Add dr_mode for dwc3
In-Reply-To: <1381402195-29257-2-git-send-email-kishon@ti.com>
References: <1381402195-29257-1-git-send-email-kishon@ti.com>
 <1381402195-29257-2-git-send-email-kishon@ti.com>
Message-ID: <52580F34.8030809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/10/2013 01:49 PM, Kishon Vijay Abraham I wrote:
> From: George Cherian <george.cherian@ti.com>
> 
> Added dr_mode property in dwc3 and set its default mode to device.

If there is a specific reason why this is not set to "otg", we need
to explain it here.

AFAIK the port is meant to be used as OTG port.

> 
> Signed-off-by: George Cherian <george.cherian@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
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

cheers,
-roger
