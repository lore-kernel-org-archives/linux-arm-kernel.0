From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 24 Oct 2014 22:12:39 +0900
Subject: [PATCHv4 0/3] ARM: dts: Add new board dts file for Exynos3250-based
 Rinato board
Message-ID: <1414156362-5752-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds new board dts file for Samsung Rinato board (Gear 2) which
is based on Exynos3250 SoC and adds sleep mode pin configuration using pinctrl
subsystem to reduce leakage power-consumption in sleep state.

This patchset is based on linux-samsung.git (for-next branch).

Changes from v3:
- Fix wrong email address
- Remove 'vemmc_reg' fixed regulator and then use 'ldo12_reg' for mshc_0 

Changes from v2:
- Separate patch3 from patchset[1] and then this patchset includes patch3.
  After applied patch3, the power-consumption of Rinato board is 0.6mA in suspend state.
  [1] [PATCHv5 0/3] regulator: of: Add support for parsing regulator suspend state
  : https://lkml.org/lkml/2014/10/10/161
- Change PDN (Power-down mode) state for GPE0-3 (BT_UART_RTS) because Rinato
  board uses UART1 for bluetooth device. BT_UART_RTS pin should be disabled in
  suspend state by setting high state of GPE0-3
- Turn on always the regulator state of VAP_VMIPI_1.0V because if VAP_VMIPI_1.0V
  is off state or would be not controlled by DRM driver, happen imprecise external abort.

Changes from v1:
- Remove useless brace
- Remove unneeded 'regulators' keyword
- Consolidate memory information in one entry

Chanwoo Choi (3):
  ARM: dts: Add board dts file for Exynos3250-based Rinato board
  ARM: dts: Add sleep mode pin configuration for exynos3250-rinato
  ARM: dts: Add sleep mode of regulator for exynos3250-rinato board

 arch/arm/boot/dts/Makefile                |   3 +-
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi |  16 +
 arch/arm/boot/dts/exynos3250-rinato.dts   | 686 ++++++++++++++++++++++++++++++
 3 files changed, 704 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/exynos3250-rinato.dts

-- 
1.8.5.5
