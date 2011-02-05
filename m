From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 5 Feb 2011 10:18:42 +0800
Subject: [PATCH 2/7] ARM: mxs/clock: fix base address missing in
	name##_set_parent
In-Reply-To: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1296872327-21166-3-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/clock-mx23.c |    2 +-
 arch/arm/mach-mxs/clock-mx28.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index 350b28c..c19b69a 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -347,7 +347,7 @@ static int name##_set_parent(struct clk *clk, struct clk *parent)	\
 {									\
 	if (parent != clk->parent) {					\
 		__raw_writel(BM_CLKCTRL_CLKSEQ_BYPASS_##bit,		\
-			 HW_CLKCTRL_CLKSEQ_TOG);			\
+			CLKCTRL_BASE_ADDR + HW_CLKCTRL_CLKSEQ_TOG);	\
 		clk->parent = parent;					\
 	}								\
 									\
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index a3b4787..9f4ee36 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -483,7 +483,7 @@ static int name##_set_parent(struct clk *clk, struct clk *parent)	\
 {									\
 	if (parent != clk->parent) {					\
 		__raw_writel(BM_CLKCTRL_CLKSEQ_BYPASS_##bit,		\
-			 HW_CLKCTRL_CLKSEQ_TOG);			\
+			CLKCTRL_BASE_ADDR + HW_CLKCTRL_CLKSEQ_TOG);	\
 		clk->parent = parent;					\
 	}								\
 									\
-- 
1.7.1
