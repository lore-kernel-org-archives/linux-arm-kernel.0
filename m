From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 20 Feb 2017 10:08:39 +0100
Subject: [PATCH v5 0/9] meson-gx: reset RGMII PHYs and configure TX delay
In-Reply-To: <20170219214149.30418-1-martin.blumenstingl@googlemail.com>
References: <20170122181028.5014-1-martin.blumenstingl@googlemail.com>
 <20170219214149.30418-1-martin.blumenstingl@googlemail.com>
Message-ID: <1487581719.3734.1.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2017-02-19 at 22:41 +0100, Martin Blumenstingl wrote:
> This series adds the reset GPIOs for the (external) ethernet PHYs on
> all
> GXBB boards.
> Additionally it provides a ethernet PHY node which can be used to
> specify
> PHY-specific properties (this may be required if more boards require
> the
> "eee-broken-1000t" for the RTL8211F ethernet PHY). To make all board
> .dts
> consistent I chose to add the PHY node also for boards which don't
> have a
> RTL8211F PHY.
> 

Looks good to me. For the patchset:
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> 
> Martin Blumenstingl (9):
> ? ARM64: dts: meson-gxbb-odroidc2: add the ethernet PHY's reset GPIO
> ? ARM64: dts: meson-gxbb-p200: add the ethernet PHY's reset GPIO
> ? ARM64: dts: meson-gxbb-vega-s95: add the ethernet PHY's reset GPIO
> ? ARM64: dts: meson-gxbb-nexbox-a95x: add the ethernet PHY's reset
> GPIO
> ? ARM64: dts: meson-gxbb-wetek-hub: add the ethernet PHY's reset GPIO
> ? ARM64: dts: meson-gxbb-wetek-play2: add the ethernet PHY's reset
> GPIO
> ? ARM64: dts: meson-gxbb-p201: fix ethernet support
> ? ARM64: dts: amlogic: add the ethernet TX delay configuration
> ? ARM64: dts: meson-gx: remove the phy-mode property from meson-gx
> 
> ?arch/arm64/boot/dts/amlogic/meson-gx.dtsi??????????|??1 -
> ?.../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts????| 17
> ++++++++++++++
> ?.../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |??7 ++++++
> ?arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts????| 25
> +++++++++++++++++++++
> ?arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts????| 11 +++++++++
> ?arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi???|??6 -----
> ?.../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi??????| 21
> ++++++++++++++++-
> ?.../boot/dts/amlogic/meson-gxbb-wetek-hub.dts??????| 26
> ++++++++++++++++++++++
> ?.../boot/dts/amlogic/meson-gxbb-wetek-play2.dts????| 26
> ++++++++++++++++++++++
> ?.../boot/dts/amlogic/meson-gxl-s905d-p230.dts??????|??2 ++
> ?.../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |??2 ++
> ?arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts?????|??2 ++
> ?12 files changed, 138 insertions(+), 8 deletions(-)
> 
