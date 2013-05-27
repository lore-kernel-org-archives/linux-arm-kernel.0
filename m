From: philippe.begnic.st@gmail.com (Philippe Begnic)
Date: Mon, 27 May 2013 14:41:31 +0200
Subject: [PATCH 3/4] mfd: db8500: Update BML clock register for db8580
In-Reply-To: <1369658492-31358-1-git-send-email-philippe.begnic.st@gmail.com>
References: <1369658492-31358-1-git-send-email-philippe.begnic.st@gmail.com>
Message-ID: <1369658492-31358-4-git-send-email-philippe.begnic.st@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Begnic <philippe.begnic@st.com>

BML clock register address in DB8580 has changed.Defined a new address
under different name for DB8580.

Signed-off-by: Philippe Begnic <philippe.begnic@st.com>
---
 drivers/mfd/db8500-prcmu.c       |    1 +
 drivers/mfd/dbx500-prcmu-regs.h  |    1 +
 include/linux/mfd/dbx500-prcmu.h |    1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 66f8097..a292a1d 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -480,6 +480,7 @@ struct clk_mgt clk_mgt[PRCMU_NUM_REG_CLOCKS] = {
 	CLK_MGT_ENTRY(PER6CLK, PLL_DIV, true),
 	CLK_MGT_ENTRY(PER7CLK, PLL_DIV, true),
 	CLK_MGT_ENTRY(LCDCLK, PLL_FIX, true),
+	CLK_MGT_ENTRY(BML8580CLK, PLL_DIV, true),
 	CLK_MGT_ENTRY(BMLCLK, PLL_DIV, true),
 	CLK_MGT_ENTRY(HSITXCLK, PLL_DIV, true),
 	CLK_MGT_ENTRY(HSIRXCLK, PLL_DIV, true),
diff --git a/drivers/mfd/dbx500-prcmu-regs.h b/drivers/mfd/dbx500-prcmu-regs.h
index d14836e..ca355dd 100644
--- a/drivers/mfd/dbx500-prcmu-regs.h
+++ b/drivers/mfd/dbx500-prcmu-regs.h
@@ -32,6 +32,7 @@
 #define PRCM_PER7CLK_MGT	(0x040)
 #define PRCM_LCDCLK_MGT		(0x044)
 #define PRCM_BMLCLK_MGT		(0x04C)
+#define PRCM_BML8580CLK_MGT	(0x108)
 #define PRCM_HSITXCLK_MGT	(0x050)
 #define PRCM_HSIRXCLK_MGT	(0x054)
 #define PRCM_HDMICLK_MGT	(0x058)
diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index d0ba355..ca0790f 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -138,6 +138,7 @@ enum prcmu_clock {
 	PRCMU_G1CLK, /* Ux540 only */
 	PRCMU_SDMMCHCLK,
 	PRCMU_CAMCLK,
+	PRCMU_BML8580CLK,
 	PRCMU_NUM_REG_CLOCKS,
 	PRCMU_SYSCLK = PRCMU_NUM_REG_CLOCKS,
 	PRCMU_CDCLK,
-- 
1.7.9.5
