From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 1 Jun 2017 18:42:58 +0530
Subject: [PATCH v2 0/2] Meson8 USB PHY support
In-Reply-To: <20170520141250.27388-1-martin.blumenstingl@googlemail.com>
References: <20170506173625.19501-1-martin.blumenstingl@googlemail.com>
 <20170520141250.27388-1-martin.blumenstingl@googlemail.com>
Message-ID: <02656f9a-33d8-c009-7785-a6bd7d4b2617@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 20 May 2017 07:42 PM, Martin Blumenstingl wrote:
> The USB2 PHY in the Meson8 SoCs is identical to the one in the Meson8b
> and GXBB SoCs.
> This series adds a new compatible string for Meson8 and adjusts the
> Kconfig and MODULE_DESCRIPTION documentation as well as the dt-bindings
> accordingly.
> 
> With some additional work the same driver could be used to add USB2
> support to Meson6 SoCs as well. However, due to lack of a clock
> controller driver for Meson6 and the lack of a board Meson6 support
> is not part of this series (Meson6 uses internal mux and divider clocks
> which are provided by the USB2 PHY registers, while the newer SoCs seem
> to use an alternative clock called "clk_32k_altsel")

merged, thanks.

-Kishon
> 
> 
> Changes since v1:
> - split the dt-bindings and the driver changes into separate patches
> - rebased to apply on top of my other series "Meson GXL USB2 PHY driver"
>   (from [0]) which means that this also applies on top of "phy: Group
>   vendor specific phy drivers"
> - also update the Kconfig option name (instead of just the description)
> 
> 
> [0] http://lists.infradead.org/pipermail/linux-amlogic/2017-May/003664.html
> 
> 
> Martin Blumenstingl (2):
>   phy: meson8b-usb2: add support for the USB PHY on Meson8 SoCs
>   dt-bindings: phy: meson8b-usb2-phy: add support for the Meson8 SoCs
> 
>  Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt | 3 ++-
>  drivers/phy/amlogic/Kconfig                                | 6 +++---
>  drivers/phy/amlogic/phy-meson8b-usb2.c                     | 5 +++--
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
