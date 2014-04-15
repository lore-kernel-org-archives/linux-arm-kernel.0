From: agross@codeaurora.org (Andy Gross)
Date: Mon, 14 Apr 2014 22:10:34 -0500
Subject: [PATCH 0/3] pinctrl: qcom: Add IPQ8064 pinctrl support
Message-ID: <1397531437-9104-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches adds pinctrl support for the Qualcomm IPQ8064 platform.
The IPQ8064 uses the same TLMM block as the APQ8064, but has a different number
of pins, functions, and function assignments.  The second patch contains the
devicetree documentation.  The last patch selects PINCTRL for all ARCH_QCOM
platforms.  This allows for selection of pinctrl support via a make menuconfig.

Andy Gross (3):
  pinctrl: qcom: Add definitions for IPQ8064
  dt: Document Qualcomm IPQ8064 pinctrl binding
  ARM: qcom: Select PINCTRL by default for ARCH_QCOM

 .../bindings/pinctrl/qcom,ipq8064-pinctrl.txt      |   95 +++
 arch/arm/mach-qcom/Kconfig                         |    1 +
 drivers/pinctrl/Kconfig                            |    8 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-ipq8064.c                  |  653 ++++++++++++++++++++
 5 files changed, 758 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-ipq8064.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
