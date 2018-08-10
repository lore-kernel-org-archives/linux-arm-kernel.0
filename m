From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 10 Aug 2018 17:18:19 +0200
Subject: [PATCH 0/3] i.MX PXP scaler/CSC driver
Message-ID: <20180810151822.18650-1-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Pixel Pipeline (PXP) is a memory-to-memory graphics processing
engine that supports scaling, colorspace conversion, alpha blending,
rotation, and pixel conversion via lookup table. Different versions are
present on various i.MX SoCs from i.MX23 to i.MX7. The latest versions
on i.MX6ULL and i.MX7D have grown an additional pipeline for dithering
and e-ink update processing that is ignored by this driver.

This series adds a V4L2 mem-to-mem scaler/CSC driver for the PXP version
found on i.MX6ULL SoCs which is a size reduced variant of the i.MX7 PXP.
The driver uses only the legacy pipeline, so it should be reasonably
easy to extend it to work with the older PXP versions found on i.MX6UL,
i.MX6SX, i.MX6SL, i.MX28, and i.MX23. The driver supports scaling and
colorspace conversion. There is currently no support for rotation,
alpha-blending, and the LUTs.

regards
Philipp

Philipp Zabel (3):
  dt-bindings: media: Add i.MX Pixel Pipeline binding
  ARM: dts: imx6ull: add pxp support
  media: imx-pxp: add i.MX Pixel Pipeline driver

 .../devicetree/bindings/media/fsl-pxp.txt     |   26 +
 arch/arm/boot/dts/imx6ul.dtsi                 |    8 +
 arch/arm/boot/dts/imx6ull.dtsi                |    6 +
 drivers/media/platform/Kconfig                |    9 +
 drivers/media/platform/Makefile               |    2 +
 drivers/media/platform/imx-pxp.c              | 1455 ++++++++++++++
 drivers/media/platform/imx-pxp.h              | 1685 +++++++++++++++++
 7 files changed, 3191 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/fsl-pxp.txt
 create mode 100644 drivers/media/platform/imx-pxp.c
 create mode 100644 drivers/media/platform/imx-pxp.h

-- 
2.18.0
