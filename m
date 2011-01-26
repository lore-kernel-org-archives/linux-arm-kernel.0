From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 27 Jan 2011 06:26:36 +0800
Subject: [PATCH] ARM: mxs: fix clock base address missing
Message-ID: <1296080796-10896-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/clock-mx23.c |    2 +-
 arch/arm/mach-mxs/clock-mx28.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index b1a362e..a0296a4 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -347,7 +347,7 @@ static int name##_set_parent(struct clk *clk, struct clk *parent)	\
 {									\
 	if (parent != clk->parent) {					\
 		__raw_writel(BM_CLKCTRL_CLKSEQ_BYPASS_##bit,		\
-			 HW_CLKCTRL_CLKSEQ_TOG);			\
+			 CLKCTRL_BASE_ADDR + HW_CLKCTRL_CLKSEQ_TOG);	\
 		clk->parent = parent;					\
 	}								\
 									\
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 56312c0..44c1754 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -483,7 +483,7 @@ static int name##_set_parent(struct clk *clk, struct clk *parent)	\
 {									\
 	if (parent != clk->parent) {					\
 		__raw_writel(BM_CLKCTRL_CLKSEQ_BYPASS_##bit,		\
-			 HW_CLKCTRL_CLKSEQ_TOG);			\
+			 CLKCTRL_BASE_ADDR + HW_CLKCTRL_CLKSEQ_TOG);	\
 		clk->parent = parent;					\
 	}								\
 									\
-- 
1.7.1
