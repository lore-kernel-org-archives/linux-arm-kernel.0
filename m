From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 13 Jun 2017 15:48:28 -0400
Subject: [GIT PULL] Qualcomm Device Tree updates for 4.13
In-Reply-To: <1497383309-14226-1-git-send-email-andy.gross@linaro.org>
References: <1497383309-14226-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1497383309-14226-5-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.13

for you to fetch changes up to cff94887d55a32bf8f7095482d9ba92784280a5c:

  ARM: dts: add core I2C devices to the APQ8060 Dragonboard (2017-06-13 12:23:57 -0400)

----------------------------------------------------------------
Qualcomm Device Tree Changes for v4.13

* Fix IPQ4019 i2c0 node
* Add GSBI7 on IPQ8064
* Add misc APQ8060 devices
* Fixup USB related devices on APQ8064 and MSM8974

----------------------------------------------------------------
Bird, Tim (1):
      ARM: dts: qcom: add charger otg regulator

Christian Lamparter (1):
      ARM: dts: qcom: ipq4019: fix i2c_0 node

Linus Walleij (4):
      ARM: dts: add XOADC and IIO HWMON to MSM8660/APQ8060
      ARM: dts: Qualcomm APQ8060 DragonBoard ALS sensor
      ARM: dts: add GSBI8 defines to the MSM8660 family
      ARM: dts: add core I2C devices to the APQ8060 Dragonboard

Stephen Boyd (3):
      ARM: dts: qcom: Remove s4/5vs1,2 from RPM pm8941 control
      ARM: dts: qcom-msm8974: Add HS usb node and OTG detection mechanisms
      ARM: dts: qcom-apq8064: Collapse usb support into one node

Sven Eckelmann (1):
      ARM: dts: qcom: add gsbi7 serial to ipq8064 SoC device tree

 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts     | 129 +++++++++++++++++
 .../arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts |  48 +++----
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts |  20 +--
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts        |  53 ++++---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |  53 ++++---
 .../arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts |  16 +--
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 154 ++++++++++++---------
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts     |  20 +++
 arch/arm/boot/dts/qcom-ipq4019.dtsi                |   4 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |  23 +++
 arch/arm/boot/dts/qcom-msm8660.dtsi                |  84 +++++++++++
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   |   1 -
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  54 +++++++-
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |  36 ++++-
 14 files changed, 512 insertions(+), 183 deletions(-)
