From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 17 Dec 2015 14:34:00 -0600
Subject: [GIT PULL] Qualcomm DT Updates for v4.5
Message-ID: <1450384440-4337-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dt-for-4.5

for you to fetch changes up to 4add1074576758fb23b7369ea62de09dac16561e:

  arm: dts: Add support for PMA8084 on APQ8084 (2015-12-15 23:35:19 -0600)

----------------------------------------------------------------
Qualcomm ARM Based Device Tree Updates for v4.5

* Add support for Sony Xperia Z
* Updates for Sony Honami board
* Updates for APQ8064 generic platform
* Updates for MSM8974 generic platform
* Add fixed rate oscillators for MSM8960 and APQ8064
* Add documentation for SMSM and SMP2P
* Fixup PMIC compat strings
* Add support for SMEM, RPM/SMD on APQ8084
* Fixup compat on IFC5640

----------------------------------------------------------------
Andy Gross (3):
      arm: dts: Add APQ8084 SMEM nodes
      arm: dts: Add RPM/SMD support on APQ8084
      arm: dts: Add support for PMA8084 on APQ8084

Bjorn Andersson (14):
      ARM: dts: qcom: msm8974-honami: Define pinctrl state for blsp_uart2
      ARM: dts: qcom: msm8974-honami: Add regulator nodes for Honami
      ARM: dts: qcom: msm8974-honami: Introduce gpio-keys
      ARM: dts: qcom: msm8974-honami: Add sdhci1 node
      ARM: dts: qcom: msm8974-honami: Add uSD slot nodes
      ARM: dts: qcom: msm8974-honami: Specify charging parameters
      dt-binding: soc: qcom: Add Qualcomm SMSM device tree documentation
      dt-binding: soc: qcom: Introduce qcom, smp2p binding documentation
      ARM: dts: qcom: apq8064: Add hwmutex and SMEM nodes
      ARM: dts: qcom: apq8064: Declare all pm8921 regulators
      ARM: dts: qcom: apq8064: Introduce gsbi5 and gsbi5 serial node
      ARM: dts: qcom: apq8064: Introduce Sony Xperia Z dts
      ARM: dts: qcom: msm8974: Disable wled and move it to honami
      ARM: dts: qcom: msm8974: Add i2c8 node

Georgi Djakov (1):
      arm: dts: qcom: apq8064: Add fixed rate on-board oscillators

Ivan T. Ivanov (1):
      ARM: dts: qcom: apq8064-ifc6410 Use hardware flow control for GSBI6

John Stultz (1):
      devicetree: Add hardware rng entry to qcom-apq8064.dtsi

Stephen Boyd (4):
      arm: dts: qcom: Add board clocks
      arm: dts: qcom: Update ifc6540 compat for qcom boot format
      arm: dts: qcom: Add aliases for PMICs
      arm: dts: qcom: Add generic PMIC gpio/MPP compat strings

 .../devicetree/bindings/soc/qcom/qcom,smp2p.txt    | 104 +++++
 .../devicetree/bindings/soc/qcom/qcom,smsm.txt     | 104 +++++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts        |  16 +-
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |  22 +-
 .../arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts | 436 +++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 130 +++++-
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts     |   2 +
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts         |   3 +-
 arch/arm/boot/dts/qcom-apq8084-mtp.dts             |   1 +
 arch/arm/boot/dts/qcom-apq8084.dtsi                | 108 +++++
 arch/arm/boot/dts/qcom-msm8960.dtsi                |  23 ++
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   | 382 ++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  11 +
 arch/arm/boot/dts/qcom-pm8841.dtsi                 |  10 +-
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |  21 +-
 arch/arm/boot/dts/qcom-pma8084.dtsi                |  12 +-
 17 files changed, 1340 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smsm.txt
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts
