From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Tue, 24 Apr 2018 09:58:43 +0200
Subject: [PATCH] clk: stm32mp1: Add CLK_IGNORE_UNUSED to ck_sys_dbg clock
Message-ID: <1524556723-26926-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Don't disable the dbg clock if was set by bootloader.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index edd3cf4..35dabf1 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1988,7 +1988,8 @@ enum {
 		  _DIV(RCC_MCO2CFGR, 4, 4, 0, NULL)),
 
 	/* Debug clocks */
-	GATE(CK_DBG, "ck_sys_dbg", "ck_axi", 0, RCC_DBGCFGR, 8, 0),
+	GATE(CK_DBG, "ck_sys_dbg", "ck_axi", CLK_IGNORE_UNUSED,
+	     RCC_DBGCFGR, 8, 0),
 
 	COMPOSITE(CK_TRACE, "ck_trace", ck_trace_src, CLK_OPS_PARENT_ENABLE,
 		  _GATE(RCC_DBGCFGR, 9, 0),
-- 
1.9.1
