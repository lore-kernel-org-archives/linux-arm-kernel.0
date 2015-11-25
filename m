From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 24 Nov 2015 17:08:27 -0800
Subject: [PATCH 0/3] Remove ARCH_MSM* configs
Message-ID: <1448413710-8101-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series allows us to remove the ARCH_MSM* configs that live
in mach-qcom/Kconfig. They're mostly proxy configs for user selectable
clocksource configurations anyway. The first patch can go via Daniel,
while the other two can go via Andy.

Stephen Boyd (3):
  clocksource: defbool CLKSRC_QCOM=y on ARCH_QCOM and make it visible
  ARM: qcom_defconfig: Enable HAVE_ARM_ARCH_TIMER
  ARM: qcom: Drop ARCH_MSM* configs

 arch/arm/configs/qcom_defconfig |  1 +
 arch/arm/mach-qcom/Kconfig      | 16 ----------------
 drivers/clocksource/Kconfig     |  3 ++-
 3 files changed, 3 insertions(+), 17 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
