From: andy.gross@linaro.org (Andy Gross)
Date: Sat, 21 Jul 2018 23:10:19 -0500
Subject: [GIT PULL] Qualcomm ARM64 DT updates for 4.19
In-Reply-To: <1532232622-18275-1-git-send-email-andy.gross@linaro.org>
References: <1532232622-18275-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1532232622-18275-2-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.19

for you to fetch changes up to e53db018315b7660bb7000a29e79faff2496c2c2:

  arm64: dts: qcom: db410c: Fix Bluetooth LED trigger (2018-07-21 15:31:02 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.19

* Add support for PM8005/PM8998 and related nodes
* Add/fix nodes on SDM845 for I2c, SPI, UART, and RPMH
* Fix BT LED trigger on DB410c
* Drop legacy clock names on MSM8916
* Add gpio line names on DB820c

----------------------------------------------------------------
Douglas Anderson (5):
      arm64: dts: qcom: sdm845: Add I2C, SPI, and UART9 nodes
      arm64: dts: qcom: sdm845: Enable debug UART and I2C10 on sdm845-mtp
      arm64: dts: sdm845: Add rpmh-rsc node
      arm64: dts: sdm845: Add rpmh-clk node
      arm64: dts: sdm845: Default qupv3_id_0 as "disabled" like _id_1

Loic Poulain (1):
      arm64: dts: qcom: db410c: Fix Bluetooth LED trigger

Manivannan Sadhasivam (1):
      arm64: dts: qcom: db820c: Add gpio-line-names property

Niklas Cassel (1):
      arm64: dts: msm8916: drop legacy suffix for clocks used by MSM DRM driver

Stephen Boyd (2):
      arm64: dts: qcom: Add pmu node to sdm845
      arm64: dts: qcom: Add pm8005 and pm8998 support

 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi    |   2 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 239 +++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi        |  28 +-
 arch/arm64/boot/dts/qcom/pm8005.dtsi         |  33 ++
 arch/arm64/boot/dts/qcom/pm8998.dtsi         |  55 ++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts      |  45 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi         | 764 +++++++++++++++++++++++++++
 7 files changed, 1151 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8005.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8998.dtsi
