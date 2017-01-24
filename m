From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 24 Jan 2017 00:48:13 -0600
Subject: [GIT PULL] Qualcomm Device Tree Changes for v4.11
In-Reply-To: <1485240494-8040-1-git-send-email-andy.gross@linaro.org>
References: <1485240494-8040-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1485240494-8040-4-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.11

for you to fetch changes up to 7a5c275fd82185e98969d3370d55b5b5473fc3ba:

  ARM: dts: qcom: Add apq8064 CoreSight components (2017-01-13 12:42:00 -0600)

----------------------------------------------------------------
Qualcomm Device Tree Changes for v4.11

* Add Coresight components for APQ8064
* Fixup PM8058 nodes
* Add APQ8060 gyro and accel support
* Enable SD600 HDMI support
* Add RIVA supprort for Sony Yuga and SD600
* Add PM8821 support
* Add MSM8974 ADSP, USB gadget, SMD, and SMP2P support
* Fix IPQ8064 clock frequencies

----------------------------------------------------------------
Bjorn Andersson (7):
      ARM: dts: qcom: msm8974: Add USB gadget nodes
      ARM: dts: msm8974: Add ADSP smp2p and smd nodes
      ARM: dts: msm8974: Add ADSP PIL node
      ARM: dts: qcom: apq8064: Add riva-pil node
      ARM: dts: qcom: apq8064-sony-yuga: Enable riva-pil
      ARM: dts: qcom: sd600-eval: pm8921_s2 regulator properties
      ARM: dts: qcom: sd600eval: Enable riva-pil

Ivan T. Ivanov (1):
      ARM: dts: qcom: Add apq8064 CoreSight components

Linus Walleij (3):
      ARM: dts: rename MSM8660/APQ8060 pmicintc to pm8058
      ARM: dts: reference PM8058 as IRQ parent
      ARM: dts: Add gyro and accel to APQ8060 Dragonboard

Srinivas Kandagatla (4):
      ARM: dts: apq8064: add support to pm8821
      ARM: dts: move hdmi pinctrl out of board file.
      ARM: dts: sd-600eval: add hdmi support
      ARM: dts: sd-600eval: enable 1.8v regulator on LS expansion

Stephen Boyd (2):
      ARM: dts: msm8974: Remove "unused" reserved region
      arm: dts: qcom: Fix ipq board clock rates

 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts     |  62 ++++-
 .../arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts |  69 +++++
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |  22 --
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi           |  37 +++
 .../arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts |   7 +
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 288 ++++++++++++++++++++-
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |   4 +-
 arch/arm/boot/dts/qcom-msm8660-surf.dts            |   2 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi                |  12 +-
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   |   8 +
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  96 ++++++-
 11 files changed, 560 insertions(+), 47 deletions(-)
