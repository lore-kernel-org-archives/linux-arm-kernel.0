From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Aug 2016 10:52:34 +0200
Subject: [PATCH 0/4] EBI2 bus and ethernet on MSM8660/APQ8060
Message-ID: <1472028758-29272-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the second iteration of the EBI2+ethernet series for
MSM8660/APQ8060. Things are working like a charm on the APQ8060
Dragonboard and all review comments are addressed AFAICT.

Linus Walleij (4):
  soc: qcom: add EBI2 device tree bindings
  soc: qcom: add EBI2 driver
  ARM: dts: add EBI2 to the Qualcomm MSM8660 DTSI
  ARM: dts: add SMSC ethernet on the APQ8060 Dragonboard

 .../devicetree/bindings/bus/qcom,ebi2.txt          | 136 +++++++
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts     | 130 +++++++
 arch/arm/boot/dts/qcom-msm8660.dtsi                |  17 +
 drivers/bus/Kconfig                                |   7 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/qcom-ebi2.c                            | 404 +++++++++++++++++++++
 6 files changed, 695 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/qcom,ebi2.txt
 create mode 100644 drivers/bus/qcom-ebi2.c

-- 
2.7.4
