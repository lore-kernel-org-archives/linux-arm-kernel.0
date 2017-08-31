From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Fri,  1 Sep 2017 08:20:17 +0900
Subject: [PATCH v1 0/3] add UniPhier efuse support
Message-ID: <1504221620-358-1-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for eFuse implemented on UniPhier LD20 SoCs.
The eFuse device is under soc-glue and this register implements as read only.

Keiji Hayashibara (3):
  dt-bindings: nvmem: add description for UniPhier eFuse
  nvmem: uniphier: add UniPhier eFuse driver
  arm64: dts: uniphier: add efuse node for LD20

 .../devicetree/bindings/nvmem/uniphier-efuse.txt   | 45 ++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 14 ++++
 arch/arm64/configs/defconfig                       |  1 +
 drivers/nvmem/Kconfig                              | 11 +++
 drivers/nvmem/Makefile                             |  2 +
 drivers/nvmem/uniphier-efuse.c                     | 98 ++++++++++++++++++++++
 6 files changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
 create mode 100644 drivers/nvmem/uniphier-efuse.c

-- 
2.7.4
