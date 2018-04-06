From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 6 Apr 2018 08:39:33 +0200
Subject: [PATCH 6/6] clk: stm32mp1: remove ck_apb_dbg clock
In-Reply-To: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
References: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1522996773-24129-7-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

It's recommended to use only clk_sys_dbg clock instead to activate
debug IP.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c                | 4 ----
 include/dt-bindings/clock/stm32mp1-clks.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index b7b5361..edd3cf4 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1988,10 +1988,6 @@ enum {
 		  _DIV(RCC_MCO2CFGR, 4, 4, 0, NULL)),
 
 	/* Debug clocks */
-	FIXED_FACTOR(NO_ID, "ck_axi_div2", "ck_axi", 0, 1, 2),
-
-	GATE(DBG, "ck_apb_dbg", "ck_axi_div2", 0, RCC_DBGCFGR, 8, 0),
-
 	GATE(CK_DBG, "ck_sys_dbg", "ck_axi", 0, RCC_DBGCFGR, 8, 0),
 
 	COMPOSITE(CK_TRACE, "ck_trace", ck_trace_src, CLK_OPS_PARENT_ENABLE,
diff --git a/include/dt-bindings/clock/stm32mp1-clks.h b/include/dt-bindings/clock/stm32mp1-clks.h
index 6c807fd..90ec780 100644
--- a/include/dt-bindings/clock/stm32mp1-clks.h
+++ b/include/dt-bindings/clock/stm32mp1-clks.h
@@ -229,7 +229,6 @@
 #define CK_MCO2		212
 
 /* TRACE & DEBUG clocks */
-#define DBG		213
 #define CK_DBG		214
 #define CK_TRACE	215
 
-- 
1.9.1
