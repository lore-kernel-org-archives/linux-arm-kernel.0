From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 13 Dec 2010 14:35:08 -0800
Subject: [PATCH v2 2/5] msm: add CLK_MINMAX to pmdh_clk
In-Reply-To: <1292279711-4460-1-git-send-email-dwalker@codeaurora.org>
References: <1292279711-4460-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1292279711-4460-2-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds in the CLK_MINMAX flag to the pmdh_clk since it's actual
a min/max clock instead of a single frequency clock.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/mach-msm/devices-msm7x00.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/devices-msm7x00.c b/arch/arm/mach-msm/devices-msm7x00.c
index 4e8c0bc..3bf8cb5 100644
--- a/arch/arm/mach-msm/devices-msm7x00.c
+++ b/arch/arm/mach-msm/devices-msm7x00.c
@@ -364,7 +364,7 @@ struct clk msm_clocks_7x01a[] = {
 	CLK_PCOM("mdp_clk",	MDP_CLK,	NULL, OFF),
 	CLK_PCOM("pbus_clk",	PBUS_CLK,	NULL, 0),
 	CLK_PCOM("pcm_clk",	PCM_CLK,	NULL, 0),
-	CLK_PCOM("pmdh_clk",	PMDH_CLK,	NULL, OFF ),
+	CLK_PCOM("pmdh_clk",	PMDH_CLK,	NULL, OFF | CLK_MINMAX),
 	CLK_PCOM("sdac_clk",	SDAC_CLK,	NULL, OFF),
 	CLK_PCOM("sdc_clk",	SDC1_CLK,	&msm_device_sdc1.dev, OFF),
 	CLK_PCOM("sdc_pclk",	SDC1_P_CLK,	&msm_device_sdc1.dev, OFF),
-- 
1.7.1
