From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  8 Jul 2016 11:11:58 +0200
Subject: [PATCH 0/4] soc: qcom: add EBI2 support and do ethernet
Message-ID: <1467969122-6552-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches (in additions to some orthogonal patches sent ot
netdev for the smsc911x) enables ethernet on the APQ8060 Dragonboard.

Ethernet uses the mysterious (yes that is the right word) EBI2 external
bus interface that only have sparse references in documentation and
some quite opaque code fragments here and there to support it.

If any of you can help me with documentation on this beast, I'd be
happy. The XMEMC bitfields especially.

The target for the patches is Kernel v4.9 or so, don't stress.

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
