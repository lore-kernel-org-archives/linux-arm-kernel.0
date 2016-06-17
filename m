From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 Jun 2016 22:28:04 +0200
Subject: [PATCH 0/7] APQ8060 Dragonboard support v2
Message-ID: <1466195292-28236-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Second attempt at getting a baseline upstream for the APQ8060
Dragonboard, the original.

I now also add the first I2C block and two sensors to get some
more peripherals running on it.

Switched to the hierarchical layout of DTS files.

This would be nice to have merged as a working baseline in the
qcom tree.

Linus Walleij (7):
  ARM: dts: add GPIO and MPP to MSM8660 PMIC
  ARM: dts: add SDCC5 to Qualcomm MSM8660
  ARM: dts: add L2CC and RPM with regulators for MSM8660
  ARM: dts: add I2C block in GSBI12
  ARM: dts: fix the MSM8660 RTC base address
  ARM: dts: move the fixed MMC regulator to SURF board
  ARM: dts: add Qualcomm APQ8060-based Dragonboard

 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts | 626 +++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8660-surf.dts        |  11 +
 arch/arm/boot/dts/qcom-msm8660.dtsi            | 166 ++++++-
 4 files changed, 792 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts

-- 
2.4.11
