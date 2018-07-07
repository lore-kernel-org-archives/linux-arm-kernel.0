From: pawel.mikolaj.chmiel@gmail.com (=?UTF-8?q?Pawe=C5=82=20Chmiel?=)
Date: Sat,  7 Jul 2018 12:09:38 +0200
Subject: [PATCH v4 0/5] Initial support for Samsung Galaxy S and Galaxy S 4G
Message-ID: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for Samsung Galaxy S and Galaxy S 4G.
Both are commercial phone based on Aries family.

Changes from v3:
  - Removed already applied patches
  - Fixed dts warnings in s5pv210-aries.dtsi

Changes from v2:
  - Restored pinctrl nodes order
  - Correct order of nodes in aries dtsi file
  - Added Reviewed-by to one of patches
  - Added Acked-by to one of patches
  - Squashed two patches updating samsung-boards documentation 

Changes from v1:
  - Removed duplicated and unneeded headers
  - Corrected node names
  - Formatting fixes
  - Removed unneeded pinctrl and sorted entries
  - Set correct interrupt type for max8998 pmic
  - Add missing regulators
  - Added missing commit msg
  - Added stdout-path
  - Added information why we hardcode bootargs
  - Added new patch which adds information, that there are samsung boards,
    not using exynos bases soc.
  - Split patch updating s5pv210_defconfig into three parts.
    First is result of make savedefconfig, second adds drivers required
    by both devices and last adds some options, which are usefull in booting
    typical Linux distribution.

Jonathan Bakker (2):
  ARM: dts: s5pv210: Add initial DTS for SGH-T959P phone
  dt-bindings: samsung: Document bindings for SGH-T959P board

Pawe? Chmiel (3):
  ARM: dts: s5pv210: Add initial DTS for Samsung Aries based phones
  ARM: dts: s5pv210: Add initial DTS for Samsung Galaxy S phone
  dt-bindings: samsung: Document bindings for Samsung aries boards

 .../bindings/arm/samsung/samsung-boards.txt        |   5 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/s5pv210-aries.dtsi               | 419 +++++++++++++++++++++
 arch/arm/boot/dts/s5pv210-fascinate4g.dts          |  45 +++
 arch/arm/boot/dts/s5pv210-galaxys.dts              |  77 ++++
 5 files changed, 547 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/s5pv210-aries.dtsi
 create mode 100644 arch/arm/boot/dts/s5pv210-fascinate4g.dts
 create mode 100644 arch/arm/boot/dts/s5pv210-galaxys.dts

-- 
2.7.4
