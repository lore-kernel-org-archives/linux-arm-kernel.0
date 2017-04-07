From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat,  8 Apr 2017 00:19:04 +0800
Subject: [PATCH 2/2] clk: sunxi-ng: fix PRCM CCU CLK_NUMBER value
In-Reply-To: <20170407161904.32624-1-icenowy@aosc.io>
References: <20170407161904.32624-1-icenowy@aosc.io>
Message-ID: <20170407161904.32624-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CLK_NUMBER value of PRCM CCU is wrongly set to (CLK_APB0_PWD + 1),
which prevented the IR mod clock from being set up.

Change it to (CLK_IR + 1) in order to correctly get IR mod set up.

Fixes: cdb8b80b6093 ("clk: sunxi-ng: add support for PRCM CCUs")

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.h b/drivers/clk/sunxi-ng/ccu-sun8i-r.h
index eaa431fd1d8f..a7a407f12b56 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r.h
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.h
@@ -22,6 +22,6 @@
 #define CLK_AHB0	1
 #define CLK_APB0	2
 
-#define CLK_NUMBER	(CLK_APB0_TWD + 1)
+#define CLK_NUMBER	(CLK_IR + 1)
 
 #endif /* _CCU_SUN8I_R_H */
-- 
2.12.2
