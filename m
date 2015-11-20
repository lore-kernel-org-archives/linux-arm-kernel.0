From: agross@codeaurora.org (Andy Gross)
Date: Fri, 20 Nov 2015 02:35:05 -0600
Subject: [PATCH 0/4] Add QCOM DWC3 Phy support
Message-ID: <1448008509-8913-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches adds support for the QCOM DWC3 phys found on various
Qualcomm platforms.  The PHY portion of this set was originally part of:

https://lkml.org/lkml/2014/9/12/597

The applicable review comments were fixed and additional changes were made to
accomodate the TCSR phy mux selection required to get working ports.

Andy Gross (4):
  phy: Add Qualcomm DWC3 HS/SS PHY driver
  usb: dwc3: qcom: Configure TCSR phy mux register
  ARM: dts: qcom: Add DWC3 USB support on IPQ8064
  Documentation: usb: dwc3: qcom: Add TCSR mux usage

 .../devicetree/bindings/usb/qcom,dwc3.txt          |  11 +
 arch/arm/boot/dts/qcom-ipq8064-ap148.dts           |  24 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |  89 ++++
 drivers/phy/Kconfig                                |  11 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-qcom-dwc3.c                        | 483 +++++++++++++++++++++
 drivers/usb/dwc3/dwc3-qcom.c                       |  25 ++
 7 files changed, 644 insertions(+)
 create mode 100644 drivers/phy/phy-qcom-dwc3.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
