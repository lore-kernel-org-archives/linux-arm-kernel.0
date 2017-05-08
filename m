From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 8 May 2017 17:40:40 +0530
Subject: [PATCH] phy: meson8b-usb2: add support for the USB PHY on Meson8
 SoCs
In-Reply-To: <20170506173625.19501-1-martin.blumenstingl@googlemail.com>
References: <20170506173625.19501-1-martin.blumenstingl@googlemail.com>
Message-ID: <950abc53-df2d-93dd-68d1-e9868445bb93@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Saturday 06 May 2017 11:06 PM, Martin Blumenstingl wrote:
> Meson8 uses the same USB PHY as found on the Meson8b and GXBB SoCs. Add
> a new of_device_id to indicate this. Also update the documentation
> (devicetree binding, Kconfig and MODULE_DESCRIPTION) accordingly.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt | 3 ++-
>  drivers/phy/Kconfig                                        | 4 ++--
>  drivers/phy/phy-meson8b-usb2.c                             | 5 +++--
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt b/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
> index 5fa73b9d20f5..d81d73aea608 100644
> --- a/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
> @@ -1,7 +1,8 @@
> -* Amlogic Meson8b and GXBB USB2 PHY
> +* Amlogic Meson8, Meson8b and GXBB USB2 PHY
>  
>  Required properties:
>  - compatible:	Depending on the platform this should be one of:
> +	"amlogic,meson8-usb2-phy"
>  	"amlogic,meson8b-usb2-phy"
>  	"amlogic,meson-gxbb-usb2-phy"

Please split the dt binding documentation into a separate patch.

Thanks
Kishon
