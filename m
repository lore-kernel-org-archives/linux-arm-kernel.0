From: agross@codeaurora.org (Andy Gross)
Date: Thu, 30 Jul 2015 16:16:37 -0500
Subject: [GIT PULL] qcom dt changes for 4.3
Message-ID: <1438290997-17503-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://codeaurora.org/quic/kernel/agross-msm.git tags/qcom-dt-for-4.3

for you to fetch changes up to baff39e6708e099261bac73a46377cffc9257388:

  ARM: dts: qs600: Add real regulators to sdcc (2015-07-28 14:57:47 -0500)

----------------------------------------------------------------
* Switch to use pinctrl compatible for GPIOs
* Add RPM regulators for MSM8960
* Add SPI Ethernet support on MSM8960 CDP
* Add SMEM support along with dependencies
* Add PM8921 support for GPIO and MPP
* Fix GSBI cell index
* Switch to use real regulators on APQ8064 w/ SDCC

----------------------------------------------------------------
Bjorn Andersson (3):
      ARM: dts: qcom: Replace gpio node with pinctrl node
      ARM: dts: msm8974: Add tcsr mutex node
      ARM: dts: msm8974: Add smem reservation and node

Pramod Gurav (1):
      ARM: dts: apq8064: Add DT support for GSBI6 and for UART pin mux

Srinivas Kandagatla (6):
      ARM: dts: apq8064: Add pm8921 mfd and its gpio node
      ARM: dts: apq8064: add pm8921 mpp support
      ARM: dts: apq8064: fix missing gsbi cell-index
      ARM: dts: apq8064: remove temporary fixed regulator for mmc
      ARM: dts: ifc6410: add real regulators for sdcc nodes.
      ARM: dts: qs600: Add real regulators to sdcc

Stephen Boyd (4):
      ARM: dts: qcom: Replace gpio node with pinctrl node
      ARM: dts: qcom: Add MSM8960 RPM and RPM regulator nodes
      ARM: dts: qcom: Add MSM8960 CDP RPM regulators
      ARM: dts: qcom: Add ks8851 node for wired ethernet

 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts |   20 ++
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts  |   40 ++++
 arch/arm/boot/dts/qcom-apq8064.dtsi         |   91 ++++++--
 arch/arm/boot/dts/qcom-msm8660.dtsi         |   11 +-
 arch/arm/boot/dts/qcom-msm8960-cdp.dts      |  302 +++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi         |   49 ++++-
 arch/arm/boot/dts/qcom-msm8974.dtsi         |   32 +++
 7 files changed, 523 insertions(+), 22 deletions(-)
