From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 13 Sep 2016 17:42:50 -0700
Subject: [PATCH v3 0/2] MMC: add driver for Amlogic GXBB SoCs
Message-ID: <20160914004252.512-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's an updated series for the Amlogic MMC driver.

Changes since v2:
- rework voltage regulator support
- drop read/write accessor macros
- drop descriptor struct (had endian issues)
- fix big-endian support, and tested big-endian build

This version is included in the v4.8/integ branch of my git tree
https://git.kernel.org/cgit/linux/kernel/git/khilman/linux-amlogic.git/

Also some RFC quetsions:

I think this is the exact same IP on the GXL family of SoC, so I'm
thinking about renaming all occurances of GXBB to just GX.  We can
have compatibles to match meson-gxbb and meson-gxl etc. though.

Thoughts?

Kevin Hilman (2):
  MMC: meson: initial support for GXBB platforms
  ARM64: dts: meson-gxbb: add MMC support

 .../devicetree/bindings/mmc/amlogic,meson-gxbb.txt |  29 +
 MAINTAINERS                                        |   1 +
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |  87 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |  78 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  37 +-
 drivers/mmc/host/Kconfig                           |  10 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/meson-gxbb.c                      | 838 +++++++++++++++++++++
 8 files changed, 1080 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-gxbb.txt
 create mode 100644 drivers/mmc/host/meson-gxbb.c

-- 
2.9.3
