From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  8 Aug 2016 23:24:01 +0200
Subject: [PATCH 0/4] Qualcomm MSM8660/APQ8060 EBI2 and ethernet support
Message-ID: <1470691445-27571-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is basically a resend of the earlier patches, restricted to
the ARM SoC parts. (drivers/soc usually merge through ARM SoC).

Mark, how do you want to proceed? Are you queueing all of these
for v4.9?

Linus Walleij (4):
  soc: qcom: add an EBI2 device tree bindings
  soc: qcom: add EBI2 driver
  ARM: dts: add EBI2 to the Qualcomm MSM8660 DTSI
  ARM: dts: add SMSC ethernet on the APQ8060 Dragonboard

 .../devicetree/bindings/soc/qcom/qcom,ebi2.txt     | 134 ++++++++
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts     | 130 ++++++++
 arch/arm/boot/dts/qcom-msm8660.dtsi                |  12 +
 drivers/soc/qcom/Kconfig                           |   8 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/ebi2.c                            | 371 +++++++++++++++++++++
 6 files changed, 656 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ebi2.txt
 create mode 100644 drivers/soc/qcom/ebi2.c

-- 
2.7.4
