From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Tue, 17 Oct 2017 13:41:01 +0900
Subject: [PATCH v3 0/3] add UniPhier efuse support
Message-ID: <1508215264-3745-1-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for eFuse implemented on UniPhier LD20 SoCs.
The eFuse device is under soc-glue and this register implements as read only.

patch v1
https://lkml.org/lkml/2017/8/31/880

patch v2
https://lkml.org/lkml/2017/10/6/20

Changes between v3 and v2
=========================
1. Fix use of '_' in dt-binnding documentation.


Keiji Hayashibara (3):
  dt-bindings: nvmem: add description for UniPhier eFuse
  nvmem: uniphier: add UniPhier eFuse driver
  arm64: dts: uniphier: add efuse node for LD20

 .../devicetree/bindings/nvmem/uniphier-efuse.txt   | 49 +++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 18 ++++
 drivers/nvmem/Kconfig                              | 11 +++
 drivers/nvmem/Makefile                             |  2 +
 drivers/nvmem/uniphier-efuse.c                     | 97 ++++++++++++++++++++++
 5 files changed, 177 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
 create mode 100644 drivers/nvmem/uniphier-efuse.c

-- 
2.7.4
