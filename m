From: andy.gross@linaro.org (Andy Gross)
Date: Sat, 23 Apr 2016 15:40:18 -0500
Subject: [GIT PULL] Qualcomm Device Tree Updates for v4.7
Message-ID: <1461444018-11041-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dt-for-4.7

for you to fetch changes up to 3db63602505fa30f9d8faa1512fc71dae0cbf71b:

  device-tree: nexus7: Add bq27541 battery interface to dts (2016-04-20 15:03:16 -0500)

----------------------------------------------------------------
Qualcomm Device Tree Changes for v4.7

* Add DB600C support
* Add IPQ4019 support
* Add additional nodes for APQ8064
* Fix APQ8064 pinctrls for i2c/spi
* Add MSM8974 nodes for smp2p and smd
* Modify MSM8974 memory reserve for rfsa and rmtfs
* Add support for BQ27541 on Nexus7

----------------------------------------------------------------
Bjorn Andersson (6):
      ARM: dts: msm8974: Split efs in rfsa and rmtfs
      ARM: dts: msm8974: Add node for second i2c from blsp1
      ARM: dts: msm8974: Add modem smp2p and smd nodes
      ARM: dts: qcom: apq8064: Add syscon for sic-non-secure
      ARM: dts: qcom: apq8064: Add complete smsm node
      ARM: dts: qcom: apq8064: Add smd node and all edges

John Stultz (1):
      device-tree: nexus7: Add bq27541 battery interface to dts

Matthew McClintock (10):
      qcom: ipq4019: Add basic board/dts support for IPQ4019 SoC
      dts: ipq4019: Add support for IPQ4019 DK01 board
      qcom: ipq4019: add acc and saw nodes to bring up secondary cores
      qcom: ipq4019: add watchdog node to ipq4019 SoC and DK01 device tree
      qcom: ipq4019: add support for reset via qcom,ps-hold
      qcom: ipq4019: add spi node to ipq4019 SoC and DK01 device tree
      qcom: ipq4019: add i2c node to ipq4019 SoC and DK01 device tree
      qcom: ipq4019: add cpu operating points for cpufreq support
      qcom: ipq4019: add crypto nodes to ipq4019 SoC and DK01 device tree
      qcom: ipq4019: add DMA nodes to ipq4019 SoC and DK01 device tree

Srinivas Kandagatla (13):
      ARM: dts: apq8064: fix the pinctrls for i2c and spi
      ARM: dts: apq8064: add support to gsbi1 uart
      ARM: dts: apq8064: add gsbi7 i2c support
      ARM: dts: db600c: add board support with serial
      ARM: dts: db600c: add pmic regulator supplies
      ARM: dts: db600c: Add eMMC and SD card support
      ARM: dts: db600c: add usb support
      ARM: dts: db600c: add pcie support
      ARM: dts: db600c: add on board sata support.
      ARM: dts: db600c: Add on board leds support
      ARM: dts: db600c: add i2c support
      ARM: dts: db600c: add spi support
      ARM: dts: db600c: add support to magnetometer

 arch/arm/boot/dts/Makefile                         |   2 +
 .../boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi   |  52 +++
 arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts    | 349 +++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts |   6 +
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi           |  39 +++
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 135 +++++++-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dts    |  22 ++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi      | 112 +++++++
 arch/arm/boot/dts/qcom-ipq4019.dtsi                | 267 ++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  52 ++-
 10 files changed, 1028 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019.dtsi
