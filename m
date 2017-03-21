From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Tue, 21 Mar 2017 11:45:18 +0530
Subject: [PATCH 0/5] clk: qcom: gdsc: Add support for clk control 
Message-ID: <1490076923-20194-1-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series allows clocks associated with GDSCs to be controlled
along with the powerdomains. To start with, some of the mmagic
clocks are assocaited with the mmagic gdscs on msm8996 so the
devices in these mmagic domains (vidc, mdss, their smmu instances etc)
don't have to put these in their resp. DT bindings.

Rajendra Nayak (5):
  arm64: qcom: Select PM_GENERIC_DOMAINS
  clk: Add clk_hw_get_clk() helper API to be used by clk providers
  clk: qcom: gdsc: Add support to control associated clks
  clk: qcom: gcc-msm8996: Mark gcc_mmss_noc_cfg_ahb_clk as a critical
    clock
  clk: qcom: mmcc-8996: Associate all mmagic clks with mmagic gdscs

 arch/arm64/Kconfig.platforms    |  2 ++
 drivers/clk/clk.c               | 39 +++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gcc-msm8996.c  |  2 +-
 drivers/clk/qcom/gdsc.c         | 48 +++++++++++++++++++++++++++++++++++++++--
 drivers/clk/qcom/gdsc.h         |  8 +++++++
 drivers/clk/qcom/mmcc-msm8996.c | 25 +++++++++++++++++++++
 include/linux/clk-provider.h    |  5 +++++
 7 files changed, 126 insertions(+), 3 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
