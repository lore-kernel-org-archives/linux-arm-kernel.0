From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 29 Feb 2016 17:42:11 -0600
Subject: [GIT PULL] Qualcomm DT Updates for 4.6
Message-ID: <1456789331-28780-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dt-for-4.6

for you to fetch changes up to 90bd6e8fea27c4a199d017134bbcb9f8a045a152:

  ARM: dts: ifc6410: add correct aliases to the i2c and spi bus (2016-02-26 13:15:49 -0600)

----------------------------------------------------------------
Qualcomm ARM Based Device Tree Updates for v4.6

* Add documentation for Kryo
* Add RPMCC node for APQ8064
* Updates for MSM8974
* Add board clocks
* Add support for Nexus7 device
* Fixup pmic reg properties
* Various updates/cleanups for APQ8064 based boards

----------------------------------------------------------------
Bjorn Andersson (3):
      ARM: dts: qcom: msm8974: Add additional reserved regions
      ARM: dts: qcom: msm8974: Add smsm node
      ARM: dts: qcom: msm8974: Add WCNSS SMP2P node

Georgi Djakov (1):
      arm: dts: qcom: apq8064: Add RPMCC DT node

John Stultz (2):
      devicetree: qcom-apq8064.dtsi: Add i2c3 address-cells and size-cells values
      devicetree: Add DTS file to support the Nexus7 2013 (flo) device.

Sricharan R (2):
      dts: msm8974: Add blsp2_bam dma node
      dts: msm8974: Add dma channels for blsp2_i2c1 node

Srinivas Kandagatla (11):
      ARM: dts: qcom: fix i2c lables to be inline with others
      ARM: dts: apq8064: move pinctrls to dedicated dtsi
      ARM: dts: apq8064: add pci support in CM QS600
      ARM: dts: apq8064: add i2c sleep pinctrl states.
      ARM: dts: apq8064: add spi5 device node.
      ARM: dts: ifc6410: enable spi device on expansion
      ARM: dts: apq8064: add missing i2c2 pinctrl info
      ARM: dts: apq8064: add gsbi4 with i2c node.
      ARM: dts: ifc6410: enable cam i2c device
      ARM: dts: apq8064: add i2c6 device node.
      ARM: dts: ifc6410: add correct aliases to the i2c and spi bus

Stephen Boyd (4):
      devicetree: bindings: Document Kryo cpu
      arm: dts: qcom: Add more board clocks
      devicetree: bindings: Document qcom board compatible format
      ARM: dts: qcom: Remove size elements from pmic reg properties

 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 Documentation/devicetree/bindings/arm/qcom.txt     |  51 ++++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts | 276 +++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts        |  27 ++
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |  26 +-
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi           | 208 ++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 128 +++++-----
 arch/arm/boot/dts/qcom-apq8084.dtsi                |  14 ++
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |  12 +
 arch/arm/boot/dts/qcom-msm8660.dtsi                |  20 ++
 arch/arm/boot/dts/qcom-msm8974.dtsi                | 135 +++++++++-
 arch/arm/boot/dts/qcom-pm8841.dtsi                 |   4 +-
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |  20 +-
 14 files changed, 846 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom.txt
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-pins.dtsi
