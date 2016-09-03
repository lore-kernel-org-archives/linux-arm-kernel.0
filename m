From: andy.gross@linaro.org (Andy Gross)
Date: Fri,  2 Sep 2016 22:58:05 -0500
Subject: [GIT PULL] Qualcomm ARM64 DT Updates for v4.9
Message-ID: <1472875085-18017-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.9

for you to fetch changes up to 28546b09551190c727c94d1c5c96ca609065beb2:

  arm64: dts: apq8016-sbc: Add HDMI display support (2016-08-26 15:31:51 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.9

* Updates for MSM8916 including TSCR, SMSM/SMP2P, and MBA reserve
* Update SCM node to denote being a reset-controller
* Fix broken interrupt settings
* Add TSENS nodes for MSM8916/MSM8996
* Add DB820c support
* Add MSM8916/APQ8016 display support

----------------------------------------------------------------
Archit Taneja (2):
      arm64: dts: msm8916: Add display support
      arm64: dts: apq8016-sbc: Add HDMI display support

Bjorn Andersson (4):
      arm64: dts: qcom: msm8916: Add smsm and smp2p nodes
      arm64: dts: qcom: msm8916: Add mba memory reserve
      arm64: dts: qcom: msm8916: Make scm a reset-controller
      arm64: dts: qcom: msm8916: Add tcsr syscon

Marc Zyngier (1):
      arm64: dts: qcom: Fix broken interrupt trigger settings

Rajendra Nayak (2):
      arm64: dts: msm8916: Add thermal zones, tsens and qfprom nodes
      arm64: dts: msm8996: Add thermal zones, tsens and qfprom nodes

Srinivas Kandagatla (8):
      arm64: dts: db820c: add basic board support
      arm64: dts: db820c: add support to LS-UART0
      arm64: dts: db820c: add support to LS-I2C0
      arm64: dts: db820c: add support to LS-I2C1
      arm64: dts: db820c: add support to I2C on HS
      arm64: dts: db820c: add support to LS-SPI0
      arm64: dts: db820c: add support to SPI on HS
      arm64: dts: db820c: add support to external sd card.

 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi |  48 ++++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  82 ++++++
 arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi  |  39 +++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts        |  21 ++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |  88 +++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              | 286 ++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  94 ++++++-
 8 files changed, 652 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c.dts
 create mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
