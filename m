From: andy.gross@linaro.org (Andy Gross)
Date: Fri,  2 Sep 2016 22:58:51 -0500
Subject: [GIT PULL] Qualcomm Device Tree Changes for v4.9
Message-ID: <1472875131-18077-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.9

for you to fetch changes up to 73bae19c3a3fde589b4508f3bfcc68d2f4b06f39:

  ARM: dts: msm8974: Move vreg_boost node from the honami to msm8974 (2016-09-02 13:48:22 -0500)

----------------------------------------------------------------
Qualcomm Device Tree Changes for v4.9

* Rework dr_mode on APQ8064 and Nexus7
* Add MSM8974 BLSP1 UART1 port
* Add AP148 SATA mapping
* Add support for LG Nexus 5 (Hammerhead)
* Fixup MSM8660/MSM8064 SPMI/MPP IRQs
* Add Nexus7 IMEM/reboot reason
* Add Honami touchscreen support
* Add TSENS support on MSM8974, APQ8064, and APQ8084
* Add APQ8060 Dragonboard PM8058 LEDs
* Rework VPH PWR REG for MSM8974

----------------------------------------------------------------
Bhushan Shah (6):
      ARM: dts: msm8974: Add nodes for blsp1_uart1 serial port
      ARM: dts: qcom: Add initial DTS for LG Nexus 5 Phone
      ARM: dts: msm8974-hammerhead: Add regulator nodes for hammerhead
      ARM: dts: msm8974-hammerhead: Introduce gpio-keys nodes
      ARM: dts: qcom: msm8974: Add fixed regulator node for vph-pwr-reg
      ARM: dts: msm8974: Move vreg_boost node from the honami to msm8974

Bjorn Andersson (1):
      ARM: dts: msm8974: honami: Add touchscreen

John Stultz (3):
      device-tree: nexus7: Set phy mode to otg instead of host
      device-tree: aqp8064.dtsi: Remove usb phy dr_mode = "host"
      device-tree: nexus7: Add IMEM syscon and reboot reason support

Linus Walleij (3):
      ARM: dts: MSM8064 remove flags from SPMI/MPP IRQs
      ARM: dts: MSM8660 remove flags from SPMI/MPP IRQs
      ARM: dts: add PM8058 LEDs to the APQ8060 Dragonboard

Rajendra Nayak (3):
      arm: dts: msm8974: Add thermal zones, tsens and qfprom nodes
      arm: dts: apq8064: Add thermal zones, tsens and qfprom nodes
      arm: dts: apq8084: Add thermal zones, tsens and qfprom nodes

twp at codeaurora.org (1):
      ipq8064: dts: force AP148 SATA port mapping

 .../devicetree/bindings/clock/qcom,gcc.txt         |  16 ++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts     |  39 +++
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts |  15 ++
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 180 ++++++++++++--
 arch/arm/boot/dts/qcom-apq8084.dtsi                | 103 ++++++++
 arch/arm/boot/dts/qcom-ipq8064-ap148.dts           |   1 +
 arch/arm/boot/dts/qcom-msm8660.dtsi                |  75 ++++--
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     | 262 +++++++++++++++++++++
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   |  81 +++++--
 arch/arm/boot/dts/qcom-msm8974.dtsi                | 139 +++++++++++
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |   5 +
 12 files changed, 857 insertions(+), 60 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
