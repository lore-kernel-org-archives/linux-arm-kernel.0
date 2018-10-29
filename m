From: vabhav.sharma@nxp.com (Vabhav Sharma)
Date: Mon, 29 Oct 2018 08:57:41 +0000
Subject: [PATCH v7 3/6] clk: qoriq: increase array size of cmux_to_group
In-Reply-To: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
References: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <1540759926-3641-4-git-send-email-vabhav.sharma@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Increase size of cmux_to_group array, to accomdate entry of
-1 termination.

Added -1, terminated, entry for 4080_cmux_grpX.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-qoriq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 3a1812f..e152bfb 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -79,7 +79,7 @@ struct clockgen_chipinfo {
 	const struct clockgen_muxinfo *cmux_groups[2];
 	const struct clockgen_muxinfo *hwaccel[NUM_HWACCEL];
 	void (*init_periph)(struct clockgen *cg);
-	int cmux_to_group[NUM_CMUX]; /* -1 terminates if fewer than NUM_CMUX */
+	int cmux_to_group[NUM_CMUX+1]; /* array should be -1 terminated */
 	u32 pll_mask;	/* 1 << n bit set if PLL n is valid */
 	u32 flags;	/* CG_xxx */
 };
@@ -601,7 +601,7 @@ static const struct clockgen_chipinfo chipinfo[] = {
 			&p4080_cmux_grp1, &p4080_cmux_grp2
 		},
 		.cmux_to_group = {
-			0, 0, 0, 0, 1, 1, 1, 1
+			0, 0, 0, 0, 1, 1, 1, 1, -1
 		},
 		.pll_mask = 0x1f,
 	},
-- 
2.7.4
