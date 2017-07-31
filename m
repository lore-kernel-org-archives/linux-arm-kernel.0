From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Mon, 31 Jul 2017 12:14:40 +0530
Subject: [PATCH 0/4] arm64: dt: msm8996: Enable support for qmp and qusb2 phy,
 and USB
Message-ID: <1501483484-2207-1-git-send-email-vivek.gautam@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding patches to enable qusb2 and qmp phy controller for PCIe and USB,
and to enable USB 2.0 and 3.0 support on msm8996 chipset.
Enabling the support for apq8096-db820c board.

Patch series dependencies:
1) Glink-rpm device tree support for 8996:
   https://www.spinics.net/lists/linux-arm-msm/msg29046.html
2) Dt binding fix for pipe clock source:
   a. https://patchwork.kernel.org/patch/9870865/
   b. https://patchwork.kernel.org/patch/9870871/
3) pmi8994 gpio support:
   https://lkml.org/lkml/2017/7/28/346

Tested the series on dragonboard db820c target.

Vivek Gautam (4):
  arm64: dts: msm8996: Add device node for qcom qusb2 phy
  arm64: dts: msm8996: Add device node for qcom qmp-phy for usb
  arm64: dts: msm8996: Add device node for qcom qmp-phy for pcie
  arm64: dts: msm8996: Add device node for qcom,dwc3

 .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi    |  24 +++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |  50 +++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 203 +++++++++++++++++++++
 3 files changed, 277 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
