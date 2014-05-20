From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Tue, 20 May 2014 15:17:28 +0200
Subject: [PATCH v7 0/4] Add STiH407 SoC and reference board support
Message-ID: <1400591852-17577-1-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds basic support to the STMicroelectronics STiH407 SoC and its
B2120 reference board. The STiH407 is a dual-core ARM Cortex-A9 CPU aimed at
STB market.

Changes since v6:
-----------------
    - No more uppercase and camelcase in DT labels and node names

Changes since v5:
-----------------
    - Sort STi boards in DTS'es Makefile
    - Re-order compatibles in STi boards from specific to generic
    - Only contains DT patches, other patches being merged

Changes since v4:
-----------------
    - remove patches already present in v3.15 (pinctrl)
    - rebase on top of v3.15-rc2

Changes since v3:
-----------------
    - Removed SOC_STIH407 as unused for now
    - Cosmetic changes in DT
    - Added new lines in pinctrl-st around if:s
    - Use ARRAY_SIZE instead of raw values

Changes since v2:
-----------------
    - Reordered the pinctrl patches
    - Moved stih407_flashdata to stih407 pinctrl patch

Changes since v1:
-----------------
    - Changed patch 2 commit title
    - Rebased pinctrl patches to linux-pinctrl/devel
    - Rebased ARM patches to arm_soc/for-next

Maxime Coquelin (4):
  ARM: dts: Sort STi boards in Makefile
  ARM: dts: Fix STi boards compatibles
  ARM: dts: Add STiH407 SoC support
  ARM: dts: STiH407: Add B2120 board support

 arch/arm/boot/dts/Makefile             |   5 +-
 arch/arm/boot/dts/stih407-b2120.dts    |  78 +++++
 arch/arm/boot/dts/stih407-clock.dtsi   |  39 +++
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 615 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stih407.dtsi         | 263 ++++++++++++++
 arch/arm/boot/dts/stih415-b2000.dts    |   2 +-
 arch/arm/boot/dts/stih415-b2020.dts    |   2 +-
 arch/arm/boot/dts/stih416-b2000.dts    |   3 +-
 arch/arm/boot/dts/stih416-b2020.dts    |   3 +-
 9 files changed, 1002 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/stih407-b2120.dts
 create mode 100644 arch/arm/boot/dts/stih407-clock.dtsi
 create mode 100644 arch/arm/boot/dts/stih407-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stih407.dtsi

-- 
1.9.1
