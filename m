From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Mon,  7 Mar 2011 19:36:57 +0530
Subject: [PATCH v1 1/1] davinci: macro rename DA8XX_LPSC0_DMAX to
	DA8XX_LPSC0_PRUSS.
Message-ID: <1299506818-11785-1-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMAX is an internal name for the module which is
known as PRUSS in TI public documentation. This patch just
gets the code in sync with TI documentation.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
---
 arch/arm/mach-davinci/da830.c            |    2 +-
 arch/arm/mach-davinci/include/mach/psc.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index ec23ab4..0577a5d 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -148,7 +148,7 @@ static struct clk scr2_ss_clk = {
 static struct clk dmax_clk = {
 	.name		= "dmax",
 	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC0_DMAX,
+	.lpsc		= DA8XX_LPSC0_PRUSS,
 	.flags		= ALWAYS_ENABLED,
 };
 
diff --git a/arch/arm/mach-davinci/include/mach/psc.h b/arch/arm/mach-davinci/include/mach/psc.h
index 62b0858..a47e6f2 100644
--- a/arch/arm/mach-davinci/include/mach/psc.h
+++ b/arch/arm/mach-davinci/include/mach/psc.h
@@ -150,7 +150,7 @@
 #define DA8XX_LPSC0_SCR0_SS		10
 #define DA8XX_LPSC0_SCR1_SS		11
 #define DA8XX_LPSC0_SCR2_SS		12
-#define DA8XX_LPSC0_DMAX		13
+#define DA8XX_LPSC0_PRUSS		13
 #define DA8XX_LPSC0_ARM			14
 #define DA8XX_LPSC0_GEM			15
 
-- 
1.7.2.3
