From: jianxin.pan@amlogic.com (Jianxin Pan)
Date: Tue, 14 Aug 2018 18:38:38 +0800
Subject: [PATCH v3 0/2] arm64: dts: meson-g12a: Introduce new DT files for
 Meson-G12A SoC
Message-ID: <1534243121-33589-1-git-send-email-jianxin.pan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This attempt will try to add new DT files to support Meson-G12A SoC.

1) first, Please notice that, in this patch series, the DT node about 16M reserved
memory for hwrom is removed, since it's not needed by G12A SoC.
2) second, the pclk for uart_AO need to be fixed once G12A clock_ao driver is
merged. In this version, it rely on bootloader to enable the pclk gate which 
belong to AO clock domain. Please add clk_ignore_unused to bootargs.

Changes since v2 [1]:
 - reorder subnodes
 - collect Rob's Reviewed-by

Changes since v1 [0]:
 - fix signoff typo
 - order subnodes by addresses when there is one and alphabetically when there is none

[0] https://lore.kernel.org/lkml/1533802951-49919-2-git-send-email-jianxin.pan at amlogic.com/

Jianxin Pan (2):
  dt-bindings: arm: amlogic: Add Meson G12A binding
  arm64: dts: meson-g12a: add initial g12a s905d2 SoC DT support

 Documentation/devicetree/bindings/arm/amlogic.txt |   6 +
 arch/arm64/boot/dts/amlogic/Makefile              |   1 +
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts   |  22 +++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi       | 172 ++++++++++++++++++++++
 4 files changed, 201 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi

-- 
1.9.1
