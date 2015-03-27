From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 27 Mar 2015 11:49:26 -0500 (CDT)
Subject: [GIT PULL] qcom dt changes for 4.1
Message-ID: <alpine.DEB.2.02.1503271147110.17719@galak-ubuntu.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-dt-for-4.1

for you to fetch changes up to 1be95ed01c190ca74677798348306a50ad0d46c1:

   ARM: dts: qcom: Add idle state device nodes for 8064 (2015-03-25 16:38:16 -0500)

----------------------------------------------------------------
Qualcomm ARM Based Device Tree Updates for v4.1

* Updated GIC binding to include Qualcomm GIC compatible
* Added binding and updated dts for TCSR (Top Control and Status Register)
* Added LCC clocks to IPQ8064/APQ8064/MSM8960 device trees
* Added LPASS support to IPQ8064 device tree
* Added SPMI PMIC & device support to APQ8084 and MSM8974
* Added support for MSM8916/APQ8016 SoC (64-bit) and MTP8916/SBC8016 boards
* Added support for qcom,saw2 & qcom,idle-states on MSM8974/APQ8084/APQ8064

----------------------------------------------------------------
Andy Gross (5):
       mfd: qcom,tcsr: Add device tree binding for TCSR
       arm: dts: qcom: Add TCSR support for APQ8064
       arm: dts: qcom: Add TCSR support for IPQ8064
       arm: dts: qcom: Add TCSR support for MSM8660
       arm: dts: qcom: Add TCSR support for MSM8960

Georgi Djakov (1):
       dt-bindings: Add #defines for MSM8916 clocks and resets

Ivan T. Ivanov (3):
       arm: dts: qcom: Add SPMI PMIC Arbiter nodes for APQ8084 and MSM8974
       arm: dts: qcom: Add 8x74 chipset SPMI PMIC's nodes
       arm: dts: qcom: Add APQ8084 chipset SPMI PMIC's nodes

Kenneth Westfield (1):
       arm: dts: qcom: Add LPASS Audio HW to IPQ8064 device tree

Kumar Gala (4):
       arm: qcom: dts: gic: add compatible string for Qualcomm MSM GICs
       arm: dts: qcom: Add LCC nodes
       arm64: dts: Add Qualcomm MSM8916 SoC and evaluation board dts
       arm64: dts: Add Qualcomm APQ8016 SBC evaluation board dts

Lina Iyer (8):
       devicetree: bindings: Update qcom,saw2 node bindings
       devicetree: bindings: Document qcom,idle-states
       ARM: dts: qcom: Add power-controller device node for 8074 Krait CPUs
       ARM: dts: qcom: Add power-controller device node for 8084 Krait CPUs
       ARM: dts: qcom: Update power-controller device node for 8064 Krait CPUs
       ARM: dts: qcom: Add idle states device nodes for 8974/8074
       ARM: dts: qcom: Add idle states device nodes for 8084
       ARM: dts: qcom: Add idle state device nodes for 8064

  Documentation/devicetree/bindings/arm/gic.txt      |   2 +
  .../bindings/arm/msm/qcom,idle-state.txt           |  84 +++++++++
  .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  40 ++++-
  .../devicetree/bindings/clock/qcom,gcc.txt         |   1 +
  .../devicetree/bindings/mfd/qcom,tcsr.txt          |  22 +++
  arch/arm/boot/dts/qcom-apq8064.dtsi                |  51 +++++-
  arch/arm/boot/dts/qcom-apq8074-dragonboard.dts     |   2 +
  arch/arm/boot/dts/qcom-apq8084-ifc6540.dts         |   1 +
  arch/arm/boot/dts/qcom-apq8084-mtp.dts             |   1 +
  arch/arm/boot/dts/qcom-apq8084.dtsi                |  56 +++++-
  arch/arm/boot/dts/qcom-ipq8064.dtsi                |  38 ++++
  arch/arm/boot/dts/qcom-msm8660.dtsi                |   8 +
  arch/arm/boot/dts/qcom-msm8960.dtsi                |  15 ++
  .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   |   2 +
  arch/arm/boot/dts/qcom-msm8974.dtsi                |  56 +++++-
  arch/arm/boot/dts/qcom-pm8841.dtsi                 |  18 ++
  arch/arm/boot/dts/qcom-pm8941.dtsi                 |  18 ++
  arch/arm/boot/dts/qcom-pma8084.dtsi                |  18 ++
  arch/arm64/boot/dts/Makefile                       |   1 +
  arch/arm64/boot/dts/qcom/Makefile                  |   5 +
  arch/arm64/boot/dts/qcom/apq8016-sbc.dts           |  21 +++
  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  33 ++++
  arch/arm64/boot/dts/qcom/msm8916-mtp.dts           |  22 +++
  arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi          |  33 ++++
  arch/arm64/boot/dts/qcom/msm8916.dtsi              | 196 +++++++++++++++++++++
  include/dt-bindings/clock/qcom,gcc-msm8916.h       | 156 ++++++++++++++++
  include/dt-bindings/reset/qcom,gcc-msm8916.h       | 108 ++++++++++++
  27 files changed, 989 insertions(+), 19 deletions(-)
  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,tcsr.txt
  create mode 100644 arch/arm/boot/dts/qcom-pm8841.dtsi
  create mode 100644 arch/arm/boot/dts/qcom-pm8941.dtsi
  create mode 100644 arch/arm/boot/dts/qcom-pma8084.dtsi
  create mode 100644 arch/arm64/boot/dts/qcom/Makefile
  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc.dts
  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-mtp.dts
  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
  create mode 100644 arch/arm64/boot/dts/qcom/msm8916.dtsi
  create mode 100644 include/dt-bindings/clock/qcom,gcc-msm8916.h
  create mode 100644 include/dt-bindings/reset/qcom,gcc-msm8916.h

--
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
