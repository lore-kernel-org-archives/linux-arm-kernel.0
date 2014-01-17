From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 16 Jan 2014 17:25:02 -0800
Subject: [PATCH 0/2] Enable clock controllers on MSM
Message-ID: <1389921904-3777-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add the clock controller nodes, enable the clock drivers
on MSM based platforms, and hook it up enough to get the serial console
working. This is based on the merge of Mike's clk-next branch with
linux-next-20140116. The changes need the clk-next branch because that's
where the DTS include files landed.

Perhaps this can be applied after 3.14-rc1 is out?

Stephen Boyd (2):
  ARM: dts: msm: Add clock controller nodes and hook into uart
  ARM: msm_defconfig: Enable MSM clock drivers

 arch/arm/boot/dts/qcom-msm8660-surf.dts | 11 +++++++++++
 arch/arm/boot/dts/qcom-msm8960-cdp.dts  | 18 ++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi     | 24 ++++++++++++++++++++++++
 arch/arm/configs/msm_defconfig          |  4 ++++
 4 files changed, 57 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
