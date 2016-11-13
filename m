From: andy.gross@linaro.org (Andy Gross)
Date: Sun, 13 Nov 2016 00:15:32 -0600
Subject: [GIT PULL] Qualcomm ARM64 DT Updates for v4.10
In-Reply-To: <1479017736-13564-1-git-send-email-andy.gross@linaro.org>
References: <1479017736-13564-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1479017736-13564-2-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.10

for you to fetch changes up to feeaf56ac78d283efe65ea60ec999d4bf3cf395e:

  arm64: dts: msm8994 SoC and Huawei Angler (Nexus 6P) support (2016-11-12 22:57:56 -0600)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.10

* Add Hexagon SMD/PIL nodes
* Add DB820c PMIC pins
* Fixup APQ8016 voltage ranges
* Add various MSM8996 nodes to support SMD/SMEM/SMP2P
* Add support for Huawei Nexus 6P (Angler)
* Add support for LG Nexus 5x (Bullhead)

----------------------------------------------------------------
Archit Taneja (1):
      arm64: dts: apq8016-sbc: Set up LDO2, LDO6 and LDO17 regulator voltage ranges

Bastian K?cher (1):
      arm64: dts: msm8994 SoC and Huawei Angler (Nexus 6P) support

Bjorn Andersson (3):
      arm64: dts: qcom: msm8916: Add Hexagon SMD edge
      arm64: dts: qcom: msm8916: Add Hexagon PIL node
      arm64: dts: msm8996: Add SMEM DT nodes

Jeremy McNicoll (2):
      arm64: dts: msm8992 SoC and LG Bullhead (Nexus 5X) support
      dt-bindings: qcom: Add msm899(2/4) bindings

Rajendra Nayak (1):
      arm64: dts: qcom: Add missing interrupt entry for pm8994 gpios

Srinivas Kandagatla (2):
      dts: arm64: db820c: add pmic pins specific dts file
      arm64: dts: apq8016-sbc: add analog audio support with multicodec

spjoshi at codeaurora.org (3):
      arm64: dts: msm8996: Add SMEM reserve-memory node
      arm64: dts: msm8996: Add reserve-memory nodes
      arm64: dts: msm8996: Add SMP2P and APCS nodes

 Documentation/devicetree/bindings/arm/qcom.txt     |   2 +
 arch/arm64/boot/dts/qcom/Makefile                  |   7 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  73 ++++++-
 .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi    |  15 ++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |   2 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  62 +++++-
 .../boot/dts/qcom/msm8992-bullhead-rev-101.dts     |  41 ++++
 arch/arm64/boot/dts/qcom/msm8992-pins.dtsi         |  38 ++++
 arch/arm64/boot/dts/qcom/msm8992.dtsi              | 184 ++++++++++++++++++
 .../arm64/boot/dts/qcom/msm8994-angler-rev-101.dts |  40 ++++
 arch/arm64/boot/dts/qcom/msm8994-pins.dtsi         |  38 ++++
 arch/arm64/boot/dts/qcom/msm8994.dtsi              | 216 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  82 ++++++++
 arch/arm64/boot/dts/qcom/pm8916.dtsi               |  45 ++++-
 arch/arm64/boot/dts/qcom/pm8994.dtsi               |   1 +
 15 files changed, 836 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8992-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8992.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8994-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8994.dtsi
