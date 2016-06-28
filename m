From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 27 Jun 2016 21:59:55 -0500
Subject: [GIT PULL] Qualcomm Device Tree Changes for v4.8
Message-ID: <1467082795-23207-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dt-for-4.8

for you to fetch changes up to c3d5313001b0c8e9f70807e58438c3dcd30a4817:

  dts: ipq4019: support ARMv7 PMU (2016-06-27 17:37:00 -0500)

----------------------------------------------------------------
Qualcomm Device Tree Changes for v4.8

* Reverse BAM dma node reverts
* Add BAM remote control options for affected platforms
* Enable peripherals on APQ8074 dragonboard
* Enable PMA8084 pwrky
* Fix PMIC reg entries by removing unnecessary size element
* Add SCM binding and support for all currently supported boards
* Add Qualcomm WCNSS binding documentation
* Rename db600c to SD_600eval and add peripheral nodes
* Remove gpio key entry from Nexus7
* Add APQ8060 based dragonboard and associated peripherals
* Add ARMv7 PMU for IPQ4019
* Update smem state cells to match documentation

----------------------------------------------------------------
Andy Gross (10):
      Revert "Revert "dts: msm8974: Add blsp2_bam dma node""
      Revert "Revert "dts: msm8974: Add dma channels for blsp2_i2c1 node""
      ARM: dts: qcom: Remove size elements from pmic reg
      ARM: dts: qcom: pma8084: Add pwrkey entry
      dt/bindings: firmware: Add Qualcomm SCM binding
      dts: qcom: apq8084: Add SCM firmware node
      dts: qcom: msm8974: Add SCM firmware node
      dts: qcom: apq8064: Add SCM firmware node
      ARM: dts: qcom: msm8974-honami: Set DMA as remotely controlled
      arm: dts: qcom: Update smem state cells usage

Bjorn Andersson (1):
      dt: binding: Add Qualcomm WCNSS control binding

John Stultz (1):
      device-tree: nexus7: Remove power gpio key entry and use pmic8xxx-pwrkey

Linus Walleij (7):
      ARM: dts: add GPIO and MPP to MSM8660 PMIC
      ARM: dts: add SDCC5 to Qualcomm MSM8660
      ARM: dts: add L2CC and RPM with regulators for MSM8660
      ARM: dts: add I2C block in GSBI12
      ARM: dts: fix the MSM8660 RTC base address
      ARM: dts: move the fixed MMC regulator to SURF board
      ARM: dts: add Qualcomm APQ8060-based Dragonboard

Parth Pancholi (1):
      ARM: dts: sd_600eval: Fix eMMC lockup issue

Srinivas Kandagatla (3):
      ARM: dts: apq8064: move sdcc1 pinctrl nodes to soc file
      ARM: dts: apq8064: move sdcc3 pinctrls out of baord file
      ARM: dts: apq8064: rename db600c to SD_600eval

Stephen Boyd (2):
      ARM: dts: qcom: Enable RPM regulators on apq8074 dragonboard
      ARM: dts: qcom: Enable sdcard and emmc on apq8074 dragonboard

twp at codeaurora.org (1):
      dts: ipq4019: support ARMv7 PMU

 .../devicetree/bindings/firmware/qcom,scm.txt      |  28 +
 .../devicetree/bindings/soc/qcom/qcom,wcnss.txt    | 116 ++++
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts     | 626 +++++++++++++++++++++
 ...tsi => qcom-apq8064-arrow-sd-600eval-pins.dtsi} |   0
 ...b600c.dts => qcom-apq8064-arrow-sd-600eval.dts} |  10 +-
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts |   6 -
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi           |  40 ++
 .../arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts |  44 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi                |  10 +-
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts     | 247 ++++++++
 arch/arm/boot/dts/qcom-apq8084.dtsi                |   8 +
 arch/arm/boot/dts/qcom-ipq4019.dtsi                |   6 +
 arch/arm/boot/dts/qcom-msm8660-surf.dts            |  11 +
 arch/arm/boot/dts/qcom-msm8660.dtsi                | 166 +++++-
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   |   4 +
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  28 +-
 arch/arm/boot/dts/qcom-pma8084.dtsi                |  20 +-
 18 files changed, 1296 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt
 create mode 100644 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
 rename arch/arm/boot/dts/{qcom-apq8064-arrow-db600c-pins.dtsi => qcom-apq8064-arrow-sd-600eval-pins.dtsi} (100%)
 rename arch/arm/boot/dts/{qcom-apq8064-arrow-db600c.dts => qcom-apq8064-arrow-sd-600eval.dts} (96%)
