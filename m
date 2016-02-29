From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 29 Feb 2016 17:43:15 -0600
Subject: [GIT PULL] Qualcomm ARM64 Updates for 4.6
Message-ID: <1456789395-28868-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.6

for you to fetch changes up to 4bd40f6cebaca4a4fa023f27300d8268b15156e7:

  arm64: dts: qcom: Fix MPP's function used for LED control (2016-02-29 16:17:45 -0600)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.6

* Add MSM8996 support
* Cleanups for MSM8916
* Updates for APQ8016 SBC
* Fixup pmic reg properties
* Add RPMCC node for 8916
* Add LPASS audio nodes
* Add USB support on MSM8916

----------------------------------------------------------------
Georgi Djakov (1):
      arm64: dts: qcom: msm8916: Add RPMCC DT node

Ivan T. Ivanov (1):
      arm64: dts: qcom: Fix MPP's function used for LED control

Rajendra Nayak (1):
      arm64: dts: msm8996: Add #power-domain-cells property

Srinivas Kandagatla (15):
      arm64: dts: apq8016-sbc: Add aliases to spi device.
      arm64: dts: qcom: remove redundant spi cs pins from pinconf
      arm64: dts: qcom: add correct drive strenght on cs pins
      arm64: dts: remove s2 regulator from smd regulators.
      arm64: dts: qcom: add lable for smd rpm regulators
      arm64: dts: apq8016-sbc: add regulators support
      arm64: dts: apq8016-sbc: make 1.8v available on LS expansion
      arm64: dts: apq8016-sbc: move sdhci node under soc node
      arm64: dts: apq8016-sbc: Add real regulators and pinctrl for sdhc
      arm64: dts: qcom: add manual pullup setting to otg.
      arm64: dts: qcom: apq8016-sbc: add usb support
      arm64: dts: qcom: add audio pinctrls
      arm64: dts: qcom: add lpass node
      arm64: dts: qcom: apq8016-sbc: enable lpass on DB410c
      arm64: dts: qcom: fix usb digital voltage levels

Stephen Boyd (6):
      arm64: dts: Add msm8996 SoC and MTP board support
      arm64: dts: qcom: Add pm8994, pmi8994, pm8004 PMIC skeletons
      arm64: dts: qcom: Add pm8994 gpios and MPPs
      arm64: dts: Rename qcom,gcc node to clock-controller
      arm64: dts: Add L2 cache node to msm8916
      ARM64: dts: qcom: Remove size elements from pmic reg properties

 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi |   2 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi |  14 ++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          | 170 ++++++++++++-
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi         | 238 +++++++++++++++++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  48 +++-
 arch/arm64/boot/dts/qcom/msm8996-mtp.dts           |  21 ++
 arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi          |  30 +++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 269 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8004.dtsi               |  19 ++
 arch/arm64/boot/dts/qcom/pm8916.dtsi               |  10 +-
 arch/arm64/boot/dts/qcom/pm8994.dtsi               |  62 +++++
 arch/arm64/boot/dts/qcom/pmi8994.dtsi              |  19 ++
 13 files changed, 880 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8004.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8994.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pmi8994.dtsi
