From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Mon, 11 Mar 2013 10:35:59 +0530
Subject: [PATCH 2/8] memory: emif: setup LP settings on freq update
In-Reply-To: <1362978365-5593-1-git-send-email-lokeshvutla@ti.com>
References: <1362978365-5593-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1362978365-5593-3-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ambresh K <ambresh@ti.com>

Program the power management shadow register on freq update
Else the concept of threshold frequencies dont really matter
as the system always uses the performance mode timing for LP
which is programmed in at init time.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Ambresh K <ambresh@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/memory/emif.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 622638c..16f5089 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -815,6 +815,8 @@ static void setup_registers(struct emif_data *emif, struct emif_regs *regs)
 
 	writel(regs->sdram_tim2_shdw, base + EMIF_SDRAM_TIMING_2_SHDW);
 	writel(regs->phy_ctrl_1_shdw, base + EMIF_DDR_PHY_CTRL_1_SHDW);
+	writel(regs->pwr_mgmt_ctrl_shdw,
+	       base + EMIF_POWER_MANAGEMENT_CTRL_SHDW);
 
 	/* Settings specific for EMIF4D5 */
 	if (emif->plat_data->ip_rev != EMIF_4D5)
-- 
1.7.9.5
