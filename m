From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 16 Aug 2017 10:17:10 -0500
Subject: [GIT PULL] Qualcomm ARM64 DT updates for 4.14
Message-ID: <1502896630-6948-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.14

for you to fetch changes up to 6a6729f384365db9443a867bf8cf22255b3da582:

  arm64: dts: qcom: msm8916: Add IOMMU support (2017-08-16 10:09:03 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.14

* Force USB host mode on APQ8016
* Update coresight nodes on MSM8916
* Add MSM8996 support for USB, PCIE phy, RPM/GLink, and modem SMP2P
* Add db820c PM8994 regulator node
* Add PMI8994 gpios
* Add assorted MSM8916 nodes including GPU, IOMMU, Venus, and CEC clock.

----------------------------------------------------------------
Bjorn Andersson (3):
      arm64: dts: qcom: Add RPM glink nodes to msm8996
      arm64: dts: msm8996: Add modem smp2p nodes
      arm64: dts: qcom: msm8996: Specify smd-edge for ADSP

Hans Verkuil (1):
      arm64: dts: qcom: add cec clock for apq8016 board

Rajendra Nayak (1):
      arm64: dts: qcom: db820c: Add pm8994 regulator node

Rob Clark (2):
      arm64: dts: qcom: msm8916: Add gpu support
      arm64: dts: qcom: msm8916: Add IOMMU support

Stanimir Varbanov (1):
      arm64: dts: qcom: msm8916: Add Venus video codec support

Stephen Boyd (1):
      arm64: dts: qcom: Force host mode for USB on apq8016-sbc

Suzuki K. Poulose (1):
      arm64: dts: qcom-msm8916: dts: Update coresight replicator

Vivek Gautam (5):
      arm64: dts: pmi8994: Add device node for pmi8994 gpios
      arm64: dts: msm8996: Add device node for qcom qusb2 phy
      arm64: dts: msm8996: Add device node for qcom qmp-phy for usb
      arm64: dts: msm8996: Add device node for qcom qmp-phy for pcie
      arm64: dts: msm8996: Add device node for qcom,dwc3

 .../arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi |   1 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  17 +-
 .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi    |  24 ++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       | 198 +++++++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              | 120 +++++++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 314 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pmi8994.dtsi              |  17 ++
 7 files changed, 680 insertions(+), 11 deletions(-)
