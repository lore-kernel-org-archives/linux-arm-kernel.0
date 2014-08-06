From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  6 Aug 2014 11:15:09 -0700
Subject: [PATCH 0/3] IPQ NSS/GMAC clock support
Message-ID: <1407348912-9124-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NSS and GMAC clocks were missing from the initial IPQ clock
control driver. This patch series adds them by adding support for
PLL rate switching, generalizing the dyn_rcg code a bit to deal
with more exotic variants of the register layouts, and finally
adding support for the clocks. Please note that the last patch
depends on the safe switch hook that I've already sent out[1].

Stephen Boyd (3):
  clk: qcom: Add support for setting rates on PLLs
  clk: qcom: Add support for banked MD RCGs
  clk: qcom: Add support for NSS/GMAC clocks and resets

 drivers/clk/qcom/clk-pll.c                   |  68 ++-
 drivers/clk/qcom/clk-pll.h                   |  20 +
 drivers/clk/qcom/clk-rcg.c                   |  99 ++--
 drivers/clk/qcom/clk-rcg.h                   |   6 +-
 drivers/clk/qcom/gcc-ipq806x.c               | 710 ++++++++++++++++++++++++++-
 drivers/clk/qcom/mmcc-msm8960.c              |  28 +-
 include/dt-bindings/clock/qcom,gcc-ipq806x.h |   3 +
 include/dt-bindings/reset/qcom,gcc-ipq806x.h |  43 ++
 8 files changed, 919 insertions(+), 58 deletions(-)

[1] https://lkml.org/lkml/2014/6/24/921
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
