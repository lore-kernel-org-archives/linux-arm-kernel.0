From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 4 Nov 2016 11:55:01 +0100
Subject: [RFC PATCH v2 0/5] ARM64: Add Internal PHY support for Meson GXL
In-Reply-To: <1477932987-27871-1-git-send-email-narmstrong@baylibre.com>
References: <1477932987-27871-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <19618350-9a4b-2b4e-6853-720101e39932@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2016 05:56 PM, Neil Armstrong wrote:
> The Amlogic Meson GXL SoCs have an internal RMII PHY that is muxed with the
> external RGMII pins.
> 
> In order to support switching between the two PHYs links, extended registers
> size for mdio-mux-mmioreg must be added.
> 
> Finally, the internal PHY is added in the GXL dtsi and support for each
> board is added in intermediate board family dtsi or final dts.
> 
> This patchset depends on ARM64 dts patch at [1]
> 
> Changes since original RFC patchset at : [2]
>  - Remove meson8b experimental phy switching
>  - Switch to mdio-mux-mmioreg with extennded size support
>  - Add internal phy support for S905x and p231
>  - Add external PHY support for p230
> 
> [1] http://lkml.kernel.org/r/1477932286-27482-1-git-send-email-narmstrong at baylibre.com
> [2] http://lkml.kernel.org/r/1477060838-14164-1-git-send-email-narmstrong at baylibre.com
> 
> Neil Armstrong (5):
>   net: mdio-mux-mmioreg: Add support for 16bit and 32bit register sizes
>   net: phy: Add Meson GXL Internal PHY driver
>   ARM64: dts: meson-gxl: Add ethernet nodes with internal PHY
>   ARM64: dts: meson-gxl-p23x: Enable ethernet
>   ARM64: dts: meson-gxl-s905x: Enable internal ethernet PHY
> 
>  .../devicetree/bindings/net/mdio-mux-mmioreg.txt   |  4 +-
>  .../boot/dts/amlogic/meson-gxl-s905d-p230.dts      | 16 +++++
>  .../boot/dts/amlogic/meson-gxl-s905d-p231.dts      |  6 ++
>  .../boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi     |  4 ++
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi   |  6 ++
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 45 ++++++++++++
>  drivers/net/phy/Kconfig                            |  5 ++
>  drivers/net/phy/Makefile                           |  1 +
>  drivers/net/phy/mdio-mux-mmioreg.c                 | 60 ++++++++++++----
>  drivers/net/phy/meson-gxl.c                        | 81 ++++++++++++++++++++++
>  10 files changed, 213 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/net/phy/meson-gxl.c
> 

Hi Florian, Andrew, Sergei,

Thanks for reviews,

Since the meson-gxl dtsi has a lot of changes pending, the patches 3, 4 & 5 will be sent in a separate patchset,
and patches 1 & 2 will be send to netdev -next.

Neil
