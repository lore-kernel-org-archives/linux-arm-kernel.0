From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Fri,  6 Oct 2017 14:02:57 +0900
Subject: [PATCH v2 0/3] add UniPhier efuse support
Message-ID: <1507266180-11840-1-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for eFuse implemented on UniPhier LD20 SoCs.
The eFuse device is under soc-glue and this register implements as read only.

patch V1
https://lkml.org/lkml/2017/8/31/880

Changes between V2 and V1
=========================
1. Fix sparse warnings
2. Changed to implement without regmap
3. Convert devm_kzalloc to stack
4. Divide efuse into two areas in devicetree
5. Remove .owner settings of struct nvmem_config
6. Remove enable of CONFIG_UNIPHIER_EFUSE in defconfig
7. Other minor fixes

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
