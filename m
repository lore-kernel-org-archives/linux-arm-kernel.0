From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 16 May 2014 16:07:07 -0700
Subject: [PATCH 0/7] qcom clock updates
Message-ID: <1400281634-9313-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some bug fixes and updates to qcom clock driver. Mostly focused
on running more drivers on msm8974 based devices and some fixes found
in the process.

Stephen Boyd (7):
  clk: qcom: Fix clk_rcg2_is_enabled() check
  clk: qcom: Fix mmcc-8974's PLL configurations
  clk: qcom: Return highest rate when round_rate() exceeds plan
  clk: qcom: Support display RCG clocks
  clk: qcom: Properly support display clocks on msm8974
  clk: qcom: Support msm8974pro global clock control hardware
  clk: qcom: Return error pointers for unimplemented clocks

 .../devicetree/bindings/clock/qcom,gcc.txt         |   2 +
 drivers/clk/qcom/clk-rcg.h                         |   3 +
 drivers/clk/qcom/clk-rcg2.c                        | 304 +++++++++++++++++++--
 drivers/clk/qcom/common.c                          |   4 +-
 drivers/clk/qcom/gcc-msm8974.c                     | 130 ++++++++-
 drivers/clk/qcom/mmcc-msm8974.c                    | 118 ++++----
 include/dt-bindings/clock/qcom,gcc-msm8974.h       |   4 +
 7 files changed, 485 insertions(+), 80 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
