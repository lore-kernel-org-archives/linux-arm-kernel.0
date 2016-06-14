From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jun 2016 17:30:54 +0200
Subject: [PATCH 0/5] APQ8060 Dragonboard support
Message-ID: <1465918259-11138-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This concludes my first round of work to get the APQ8060 Dragonboard
booting properly upstream.

After the separate fix to the RPM driver, it boots and sets up all stuff
as expected, adds the serial port and the two SD card slots.

I was working on getting some stuff like the PM8901 enabled (it has four
MPP multi-purpose-pins) but that work can happen on top of this series,
let's start somewhere.

Linus Walleij (5):
  ARM: dts: add GPIO and MPP to MSM8660 PMIC
  ARM: dts: add SDCC5 to Qualcomm MSM8660
  ARM: dts: add L2CC and RPM with regulators for MSM8660
  ARM: dts: move the fixed MMC regulator to SURF board
  ARM: dts: add Qualcomm APQ8060-based Dragonboard

 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts | 557 +++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8660-surf.dts        |  11 +
 arch/arm/boot/dts/qcom-msm8660.dtsi            | 149 ++++++-
 4 files changed, 709 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts

-- 
2.4.11
