From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Wed, 11 Jul 2018 13:30:50 +0900
Subject: [PATCH v3 0/2] regulator: add new UniPhier regulator support
Message-ID: <1531283452-9705-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add new regulator controller support for UniPhier SoCs.
Currently this supports USB3 VBUS controller only. This USB3 VBUS belongs to
USB3 glue layer.

Changes since v2:
- replace functions in regulator_ops with helper ones

Changes since v1:
- dt-bindings: add description of glue layer
- replace read/write accesses with regmap_mmio
- rewrite a header with C++ comment style
- reuse soc_data for pxs2, ld20 and pxs3
- replace clk operations with clk_bulk
- move nclks and nrsts to soc_data

Kunihiko Hayashi (2):
  dt-bindings: regulator: add DT bindings for UniPhier regulator
  regulator: uniphier: add regulator driver for UniPhier SoC

 .../bindings/regulator/uniphier-regulator.txt      |  57 ++++++
 drivers/regulator/Kconfig                          |   8 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/uniphier-regulator.c             | 213 +++++++++++++++++++++
 4 files changed, 279 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
 create mode 100644 drivers/regulator/uniphier-regulator.c

-- 
2.7.4
