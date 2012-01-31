From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 31 Jan 2012 13:49:25 +0900
Subject: [PATCH 3/3] PM / devfreq: update the name of EXYNOS clock register
In-Reply-To: <1327985365-7070-1-git-send-email-kgene.kim@samsung.com>
References: <1327985365-7070-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1327985365-7070-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to replacing the name of EXYNOS clock registers,
this patch updates exynos4_bus.c file where it is used.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/devfreq/exynos4_bus.c |  224 ++++++++++++++++++++--------------------
 1 files changed, 112 insertions(+), 112 deletions(-)

diff --git a/drivers/devfreq/exynos4_bus.c b/drivers/devfreq/exynos4_bus.c
index 6460577..565aa98 100644
--- a/drivers/devfreq/exynos4_bus.c
+++ b/drivers/devfreq/exynos4_bus.c
@@ -311,51 +311,51 @@ static int exynos4210_set_busclk(struct busfreq_data *data, struct opp *opp)
 	/* Change Divider - DMC0 */
 	tmp = data->dmc_divtable[index];
 
-	__raw_writel(tmp, S5P_CLKDIV_DMC0);
+	__raw_writel(tmp, EXYNOS4_CLKDIV_DMC0);
 
 	do {
-		tmp = __raw_readl(S5P_CLKDIV_STAT_DMC0);
+		tmp = __raw_readl(EXYNOS4_CLKDIV_STAT_DMC0);
 	} while (tmp & 0x11111111);
 
 	/* Change Divider - TOP */
 	tmp = data->top_divtable[index];
 
-	__raw_writel(tmp, S5P_CLKDIV_TOP);
+	__raw_writel(tmp, EXYNOS4_CLKDIV_TOP);
 
 	do {
-		tmp = __raw_readl(S5P_CLKDIV_STAT_TOP);
+		tmp = __raw_readl(EXYNOS4_CLKDIV_STAT_TOP);
 	} while (tmp & 0x11111);
 
 	/* Change Divider - LEFTBUS */
-	tmp = __raw_readl(S5P_CLKDIV_LEFTBUS);
+	tmp = __raw_readl(EXYNOS4_CLKDIV_LEFTBUS);
 
-	tmp &= ~(S5P_CLKDIV_BUS_GDLR_MASK | S5P_CLKDIV_BUS_GPLR_MASK);
+	tmp &= ~(EXYNOS4_CLKDIV_BUS_GDLR_MASK | EXYNOS4_CLKDIV_BUS_GPLR_MASK);
 
 	tmp |= ((exynos4210_clkdiv_lr_bus[index][0] <<
-				S5P_CLKDIV_BUS_GDLR_SHIFT) |
+				EXYNOS4_CLKDIV_BUS_GDLR_SHIFT) |
 		(exynos4210_clkdiv_lr_bus[index][1] <<
-				S5P_CLKDIV_BUS_GPLR_SHIFT));
+				EXYNOS4_CLKDIV_BUS_GPLR_SHIFT));
 
-	__raw_writel(tmp, S5P_CLKDIV_LEFTBUS);
+	__raw_writel(tmp, EXYNOS4_CLKDIV_LEFTBUS);
 
 	do {
-		tmp = __raw_readl(S5P_CLKDIV_STAT_LEFTBUS);
+		tmp = __raw_readl(EXYNOS4_CLKDIV_STAT_LEFTBUS);
 	} while (tmp & 0x11);
 
 	/* Change Divider - RIGHTBUS */
-	tmp = __raw_readl(S5P_CLKDIV_RIGHTBUS);
+	tmp = __raw_readl(EXYNOS4_CLKDIV_RIGHTBUS);
 
-	tmp &= ~(S5P_CLKDIV_BUS_GDLR_MASK | S5P_CLKDIV_BUS_GPLR_MASK);
+	tmp &= ~(EXYNOS4_CLKDIV_BUS_GDLR_MASK | EXYNOS4_CLKDIV_BUS_GPLR_MASK);
 
 	tmp |= ((exynos4210_clkdiv_lr_bus[index][0] <<
-				S5P_CLKDIV_BUS_GDLR_SHIFT) |
+				EXYNOS4_CLKDIV_BUS_GDLR_SHIFT) |
 		(exynos4210_clkdiv_lr_bus[index][1] <<
-				S5P_CLKDIV_BUS_GPLR_SHIFT));
+				EXYNOS4_CLKDIV_BUS_GPLR_SHIFT));
 
-	__raw_writel(tmp, S5P_CLKDIV_RIGHTBUS);
+	__raw_writel(tmp, EXYNOS4_CLKDIV_RIGHTBUS);
 
 	do {
-		tmp = __raw_readl(S5P_CLKDIV_STAT_RIGHTBUS);
+		tmp = __raw_readl(EXYNOS4_CLKDIV_STAT_RIGHTBUS);
 	} while (tmp & 0x11);
 
 	return 0;
@@ -376,137 +376,137 @@ static int exynos4x12_set_busclk(struct busfreq_data *data, struct opp *opp)
 	/* Change Divider - DMC0 */
 	tmp = data->dmc_divtable[index];
 
-	__raw_writel(tmp, S5P_CLKDIV_DMC0);
+	__raw_writel(tmp, EXYNOS4_CLKDIV_DMC0);
 
 	do {
-		tmp = __raw_readl(S5P_CLKDIV_STAT_DMC0);
+		tmp = __raw_readl(EXYNOS4_CLKDIV_STAT_DMC0);
 	} while (tmp & 0x11111111);
 
 	/* Change Divider - DMC1 */
-	tmp = __raw_readl(S5P_CLKDIV_DMC1);
+	tmp = __raw_readl(EXYNOS4_CLKDIV_DMC1);
 
-	tmp &= ~(S5P_CLKDIV_DMC1_G2D_ACP_MASK |
-		S5P_CLKDIV_DMC1_C2C_MASK |
-		S5P_CLKDIV_DMC1_C2CACLK_MASK);
+	tmp &= ~(EXYNOS4_CLKDIV_DMC1_G2D_ACP_MASK |
+		EXYNOS4_CLKDIV_DMC1_C2C_MASK |
+		EXYNOS4_CLKDIV_DMC1_C2CACLK_MASK);
 
 	tmp |= ((exynos4x12_clkdiv_dmc1[index][0] <<
-				S5P_CLKDIV_DMC1_G2D_ACP_SHIFT) |
+				EXYNOS4_CLKDIV_DMC1_G2D_ACP_SHIFT) |
 		(exynos4x12_clkdiv_dmc1[index][1] <<
-				S5P_CLKDIV_DMC1_C2C_SHIFT) |
+				EXYNOS4_CLKDIV_DMC1_C2C_SHIFT) |
 		(exynos4x12_clkdiv_dmc1[index][2] <<
-				S5P_CLKDIV_DMC1_C2CACLK_SHIFT));
+				EXYNOS4_CLKDIV_DMC1_C2CACLK_SHIFT));
 
-	__raw_writel(tmp, S5P_CLKDIV_DMC1);
+	__raw_writel(tmp, EXYNOS4_CLKDIV_DMC1);
 
 	do {
-		tmp = __raw_readl(S5P_CLKDIV_STAT_DMC1);
+		tmp = __raw_readl(EXYNOS4_CLKDIV_STAT_DMC1);
 	} while (tmp & 0x111111);
 
 	/* Change Divider - TOP */
-	tmp = __raw_readl(S5P_CLKDIV_TOP);
+	tmp = __raw_readl(EXYNOS4_CLKDIV_TOP);
 
-	tmp &= ~(S5P_CLKDIV_TOP_ACLK266_GPS_MASK |
-		S5P_CLKDIV_TOP_ACLK100_MASK |
-		S5P_CLKDIV_TOP_ACLK160_MASK |
-		S5P_CLKDIV_TOP_ACLK133_MASK |
-		S5P_CLKDIV_TOP_ONENAND_MASK);
+	tmp &= ~(EXYNOS4_CLKDIV_TOP_ACLK266_GPS_MASK |
+		EXYNOS4_CLKDIV_TOP_ACLK100_MASK |
+		EXYNOS4_CLKDIV_TOP_ACLK160_MASK |
+		EXYNOS4_CLKDIV_TOP_ACLK133_MASK |
+		EXYNOS4_CLKDIV_TOP_ONENAND_MASK);
 
 	tmp |= ((exynos4x12_clkdiv_top[index][0] <<
-				S5P_CLKDIV_TOP_ACLK266_GPS_SHIFT) |
+				EXYNOS4_CLKDIV_TOP_ACLK266_GPS_SHIFT) |
 		(exynos4x12_clkdiv_top[index][1] <<
-				S5P_CLKDIV_TOP_ACLK100_SHIFT) |
+				EXYNOS4_CLKDIV_TOP_ACLK100_SHIFT) |
 		(exynos4x12_clkdiv_top[index][2] <<
-				S5P_CLKDIV_TOP_ACLK160_SHIFT) |
+				EXYNOS4_CLKDIV_TOP_ACLK160_SHIFT) |
 		(exynos4x12_clkdiv_top[index][3] <<
-				S5P_CLKDIV_TOP_ACLK133_SHIFT) |
+				EXYNOS4_CLKDIV_TOP_ACLK133_SHIFT) |
 		(exynos4x12_clkdiv_top[index][4] <<
-				S5P_CLKDIV_TOP_ONENAND_SHIFT));
+				EXYNOS4_CLKDIV_TOP_ONENAND_SHIFT));
 
-	__raw_writel(tmp, S5P_CLKDIV_TOP);
+	__raw_writel(tmp, EXYNOS4_CLKDIV_TOP);
 
 	do {
-		tmp = __raw_readl(S5P_CLKDIV_STAT_TOP);
+		tmp = __raw_readl(EXYNOS4_CLKDIV_STAT_TOP);
 	} while (tmp & 0x11111);
 
 	/* Change Divider - LEFTBUS */
-	tmp = __raw_readl(S5P_CLKDIV_LEFTBUS);
+	tmp = __raw_readl(EXYNOS4_CLKDIV_LEFTBUS);
 
-	tmp &= ~(S5P_CLKDIV_BUS_GDLR_MASK | S5P_CLKDIV_BUS_GPLR_MASK);
+	tmp &= ~(EXYNOS4_CLKDIV_BUS_GDLR_MASK | EXYNOS4_CLKDIV_BUS_GPLR_MASK);
 
 	tmp |= ((exynos4x12_clkdiv_lr_bus[index][0] <<
-				S5P_CLKDIV_BUS_GDLR_SHIFT) |
+				EXYNOS4_CLKDIV_BUS_GDLR_SHIFT) |
 		(exynos4x12_clkdiv_lr_bus[index][1] <<
-				S5P_CLKDIV_BUS_GPLR_SHIFT));
+				EXYNOS4_CLKDIV_BUS_GPLR_SHIFT));
 
-	__raw_writel(tmp, S5P_CLKDIV_LEFTBUS);
+	__raw_writel(tmp, EXYNOS4_CLKDIV_LEFTBUS);
 
 	do {
-		tmp = __raw_readl(S5P_CLKDIV_STAT_LEFTBUS);
+		tmp = __raw_readl(EXYNOS4_CLKDIV_STAT_LEFTBUS);
 	} while (tmp & 0x11);
 
 	/* Change Divider - RIGHTBUS */
-	tmp = __raw_readl(S5P_CLKDIV_RIGHTBUS);
+	tmp = __raw_readl(EXYNOS4_CLKDIV_RIGHTBUS);
 
-	tmp &= ~(S5P_CLKDIV_BUS_GDLR_MASK | S5P_CLKDIV_BUS_GPLR_MASK);
+	tmp &= ~(EXYNOS4_CLKDIV_BUS_GDLR_MASK | EXYNOS4_CLKDIV_BUS_GPLR_MASK);
 
 	tmp |= ((exynos4x12_clkdiv_lr_bus[index][0] <<
-				S5P_CLKDIV_BUS_GDLR_SHIFT) |
+				EXYNOS4_CLKDIV_BUS_GDLR_SHIFT) |
 		(exynos4x12_clkdiv_lr_bus[index][1] <<
-				S5P_CLKDIV_BUS_GPLR_SHIFT));
+				EXYNOS4_CLKDIV_BUS_GPLR_SHIFT));
 
-	__raw_writel(tmp, S5P_CLKDIV_RIGHTBUS);
+	__raw_writel(tmp, EXYNOS4_CLKDIV_RIGHTBUS);
 
 	do {
-		tmp = __raw_readl(S5P_CLKDIV_STAT_RIGHTBUS);
+		tmp = __raw_readl(EXYNOS4_CLKDIV_STAT_RIGHTBUS);
 	} while (tmp & 0x11);
 
 	/* Change Divider - MFC */
-	tmp = __raw_readl(S5P_CLKDIV_MFC);
+	tmp = __raw_readl(EXYNOS4_CLKDIV_MFC);
 
-	tmp &= ~(S5P_CLKDIV_MFC_MASK);
+	tmp &= ~(EXYNOS4_CLKDIV_MFC_MASK);
 
 	tmp |= ((exynos4x12_clkdiv_sclkip[index][0] <<
-				S5P_CLKDIV_MFC_SHIFT));
+				EXYNOS4_CLKDIV_MFC_SHIFT));
 
-	__raw_writel(tmp, S5P_CLKDIV_MFC);
+	__raw_writel(tmp, EXYNOS4_CLKDIV_MFC);
 
 	do {
-		tmp = __raw_readl(S5P_CLKDIV_STAT_MFC);
+		tmp = __raw_readl(EXYNOS4_CLKDIV_STAT_MFC);
 	} while (tmp & 0x1);
 
 	/* Change Divider - JPEG */
-	tmp = __raw_readl(S5P_CLKDIV_CAM1);
+	tmp = __raw_readl(EXYNOS4_CLKDIV_CAM1);
 
-	tmp &= ~(S5P_CLKDIV_CAM1_JPEG_MASK);
+	tmp &= ~(EXYNOS4_CLKDIV_CAM1_JPEG_MASK);
 
 	tmp |= ((exynos4x12_clkdiv_sclkip[index][1] <<
-				S5P_CLKDIV_CAM1_JPEG_SHIFT));
+				EXYNOS4_CLKDIV_CAM1_JPEG_SHIFT));
 
-	__raw_writel(tmp, S5P_CLKDIV_CAM1);
+	__raw_writel(tmp, EXYNOS4_CLKDIV_CAM1);
 
 	do {
-		tmp = __raw_readl(S5P_CLKDIV_STAT_CAM1);
+		tmp = __raw_readl(EXYNOS4_CLKDIV_STAT_CAM1);
 	} while (tmp & 0x1);
 
 	/* Change Divider - FIMC0~3 */
-	tmp = __raw_readl(S5P_CLKDIV_CAM);
+	tmp = __raw_readl(EXYNOS4_CLKDIV_CAM);
 
-	tmp &= ~(S5P_CLKDIV_CAM_FIMC0_MASK | S5P_CLKDIV_CAM_FIMC1_MASK |
-		S5P_CLKDIV_CAM_FIMC2_MASK | S5P_CLKDIV_CAM_FIMC3_MASK);
+	tmp &= ~(EXYNOS4_CLKDIV_CAM_FIMC0_MASK | EXYNOS4_CLKDIV_CAM_FIMC1_MASK |
+		EXYNOS4_CLKDIV_CAM_FIMC2_MASK | EXYNOS4_CLKDIV_CAM_FIMC3_MASK);
 
 	tmp |= ((exynos4x12_clkdiv_sclkip[index][2] <<
-				S5P_CLKDIV_CAM_FIMC0_SHIFT) |
+				EXYNOS4_CLKDIV_CAM_FIMC0_SHIFT) |
 		(exynos4x12_clkdiv_sclkip[index][2] <<
-				S5P_CLKDIV_CAM_FIMC1_SHIFT) |
+				EXYNOS4_CLKDIV_CAM_FIMC1_SHIFT) |
 		(exynos4x12_clkdiv_sclkip[index][2] <<
-				S5P_CLKDIV_CAM_FIMC2_SHIFT) |
+				EXYNOS4_CLKDIV_CAM_FIMC2_SHIFT) |
 		(exynos4x12_clkdiv_sclkip[index][2] <<
-				S5P_CLKDIV_CAM_FIMC3_SHIFT));
+				EXYNOS4_CLKDIV_CAM_FIMC3_SHIFT));
 
-	__raw_writel(tmp, S5P_CLKDIV_CAM);
+	__raw_writel(tmp, EXYNOS4_CLKDIV_CAM);
 
 	do {
-		tmp = __raw_readl(S5P_CLKDIV_STAT_CAM1);
+		tmp = __raw_readl(EXYNOS4_CLKDIV_STAT_CAM1);
 	} while (tmp & 0x1111);
 
 	return 0;
@@ -760,55 +760,55 @@ static int exynos4210_init_tables(struct busfreq_data *data)
 	int mgrp;
 	int i, err = 0;
 
-	tmp = __raw_readl(S5P_CLKDIV_DMC0);
+	tmp = __raw_readl(EXYNOS4_CLKDIV_DMC0);
 	for (i = LV_0; i < EX4210_LV_NUM; i++) {
-		tmp &= ~(S5P_CLKDIV_DMC0_ACP_MASK |
-			S5P_CLKDIV_DMC0_ACPPCLK_MASK |
-			S5P_CLKDIV_DMC0_DPHY_MASK |
-			S5P_CLKDIV_DMC0_DMC_MASK |
-			S5P_CLKDIV_DMC0_DMCD_MASK |
-			S5P_CLKDIV_DMC0_DMCP_MASK |
-			S5P_CLKDIV_DMC0_COPY2_MASK |
-			S5P_CLKDIV_DMC0_CORETI_MASK);
+		tmp &= ~(EXYNOS4_CLKDIV_DMC0_ACP_MASK |
+			EXYNOS4_CLKDIV_DMC0_ACPPCLK_MASK |
+			EXYNOS4_CLKDIV_DMC0_DPHY_MASK |
+			EXYNOS4_CLKDIV_DMC0_DMC_MASK |
+			EXYNOS4_CLKDIV_DMC0_DMCD_MASK |
+			EXYNOS4_CLKDIV_DMC0_DMCP_MASK |
+			EXYNOS4_CLKDIV_DMC0_COPY2_MASK |
+			EXYNOS4_CLKDIV_DMC0_CORETI_MASK);
 
 		tmp |= ((exynos4210_clkdiv_dmc0[i][0] <<
-					S5P_CLKDIV_DMC0_ACP_SHIFT) |
+					EXYNOS4_CLKDIV_DMC0_ACP_SHIFT) |
 			(exynos4210_clkdiv_dmc0[i][1] <<
-					S5P_CLKDIV_DMC0_ACPPCLK_SHIFT) |
+					EXYNOS4_CLKDIV_DMC0_ACPPCLK_SHIFT) |
 			(exynos4210_clkdiv_dmc0[i][2] <<
-					S5P_CLKDIV_DMC0_DPHY_SHIFT) |
+					EXYNOS4_CLKDIV_DMC0_DPHY_SHIFT) |
 			(exynos4210_clkdiv_dmc0[i][3] <<
-					S5P_CLKDIV_DMC0_DMC_SHIFT) |
+					EXYNOS4_CLKDIV_DMC0_DMC_SHIFT) |
 			(exynos4210_clkdiv_dmc0[i][4] <<
-					S5P_CLKDIV_DMC0_DMCD_SHIFT) |
+					EXYNOS4_CLKDIV_DMC0_DMCD_SHIFT) |
 			(exynos4210_clkdiv_dmc0[i][5] <<
-					S5P_CLKDIV_DMC0_DMCP_SHIFT) |
+					EXYNOS4_CLKDIV_DMC0_DMCP_SHIFT) |
 			(exynos4210_clkdiv_dmc0[i][6] <<
-					S5P_CLKDIV_DMC0_COPY2_SHIFT) |
+					EXYNOS4_CLKDIV_DMC0_COPY2_SHIFT) |
 			(exynos4210_clkdiv_dmc0[i][7] <<
-					S5P_CLKDIV_DMC0_CORETI_SHIFT));
+					EXYNOS4_CLKDIV_DMC0_CORETI_SHIFT));
 
 		data->dmc_divtable[i] = tmp;
 	}
 
-	tmp = __raw_readl(S5P_CLKDIV_TOP);
+	tmp = __raw_readl(EXYNOS4_CLKDIV_TOP);
 	for (i = LV_0; i <  EX4210_LV_NUM; i++) {
-		tmp &= ~(S5P_CLKDIV_TOP_ACLK200_MASK |
-			S5P_CLKDIV_TOP_ACLK100_MASK |
-			S5P_CLKDIV_TOP_ACLK160_MASK |
-			S5P_CLKDIV_TOP_ACLK133_MASK |
-			S5P_CLKDIV_TOP_ONENAND_MASK);
+		tmp &= ~(EXYNOS4_CLKDIV_TOP_ACLK200_MASK |
+			EXYNOS4_CLKDIV_TOP_ACLK100_MASK |
+			EXYNOS4_CLKDIV_TOP_ACLK160_MASK |
+			EXYNOS4_CLKDIV_TOP_ACLK133_MASK |
+			EXYNOS4_CLKDIV_TOP_ONENAND_MASK);
 
 		tmp |= ((exynos4210_clkdiv_top[i][0] <<
-					S5P_CLKDIV_TOP_ACLK200_SHIFT) |
+					EXYNOS4_CLKDIV_TOP_ACLK200_SHIFT) |
 			(exynos4210_clkdiv_top[i][1] <<
-					S5P_CLKDIV_TOP_ACLK100_SHIFT) |
+					EXYNOS4_CLKDIV_TOP_ACLK100_SHIFT) |
 			(exynos4210_clkdiv_top[i][2] <<
-					S5P_CLKDIV_TOP_ACLK160_SHIFT) |
+					EXYNOS4_CLKDIV_TOP_ACLK160_SHIFT) |
 			(exynos4210_clkdiv_top[i][3] <<
-					S5P_CLKDIV_TOP_ACLK133_SHIFT) |
+					EXYNOS4_CLKDIV_TOP_ACLK133_SHIFT) |
 			(exynos4210_clkdiv_top[i][4] <<
-					S5P_CLKDIV_TOP_ONENAND_SHIFT));
+					EXYNOS4_CLKDIV_TOP_ONENAND_SHIFT));
 
 		data->top_divtable[i] = tmp;
 	}
@@ -872,28 +872,28 @@ static int exynos4x12_init_tables(struct busfreq_data *data)
 	tmp |= DMC_PAUSE_ENABLE;
 	__raw_writel(tmp, S5P_DMC_PAUSE_CTRL);
 
-	tmp = __raw_readl(S5P_CLKDIV_DMC0);
+	tmp = __raw_readl(EXYNOS4_CLKDIV_DMC0);
 
 	for (i = 0; i <  EX4x12_LV_NUM; i++) {
-		tmp &= ~(S5P_CLKDIV_DMC0_ACP_MASK |
-			S5P_CLKDIV_DMC0_ACPPCLK_MASK |
-			S5P_CLKDIV_DMC0_DPHY_MASK |
-			S5P_CLKDIV_DMC0_DMC_MASK |
-			S5P_CLKDIV_DMC0_DMCD_MASK |
-			S5P_CLKDIV_DMC0_DMCP_MASK);
+		tmp &= ~(EXYNOS4_CLKDIV_DMC0_ACP_MASK |
+			EXYNOS4_CLKDIV_DMC0_ACPPCLK_MASK |
+			EXYNOS4_CLKDIV_DMC0_DPHY_MASK |
+			EXYNOS4_CLKDIV_DMC0_DMC_MASK |
+			EXYNOS4_CLKDIV_DMC0_DMCD_MASK |
+			EXYNOS4_CLKDIV_DMC0_DMCP_MASK);
 
 		tmp |= ((exynos4x12_clkdiv_dmc0[i][0] <<
-					S5P_CLKDIV_DMC0_ACP_SHIFT) |
+					EXYNOS4_CLKDIV_DMC0_ACP_SHIFT) |
 			(exynos4x12_clkdiv_dmc0[i][1] <<
-					S5P_CLKDIV_DMC0_ACPPCLK_SHIFT) |
+					EXYNOS4_CLKDIV_DMC0_ACPPCLK_SHIFT) |
 			(exynos4x12_clkdiv_dmc0[i][2] <<
-					S5P_CLKDIV_DMC0_DPHY_SHIFT) |
+					EXYNOS4_CLKDIV_DMC0_DPHY_SHIFT) |
 			(exynos4x12_clkdiv_dmc0[i][3] <<
-					S5P_CLKDIV_DMC0_DMC_SHIFT) |
+					EXYNOS4_CLKDIV_DMC0_DMC_SHIFT) |
 			(exynos4x12_clkdiv_dmc0[i][4] <<
-					S5P_CLKDIV_DMC0_DMCD_SHIFT) |
+					EXYNOS4_CLKDIV_DMC0_DMCD_SHIFT) |
 			(exynos4x12_clkdiv_dmc0[i][5] <<
-					S5P_CLKDIV_DMC0_DMCP_SHIFT));
+					EXYNOS4_CLKDIV_DMC0_DMCP_SHIFT));
 
 		data->dmc_divtable[i] = tmp;
 	}
-- 
1.7.4.4
