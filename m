From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 22 Jun 2014 12:34:50 +0400
Subject: [PATCH 2/2] ARM: i.MX27 clk: Remove unused definitions
In-Reply-To: <1403426090-29806-1-git-send-email-shc_work@mail.ru>
References: <1403426090-29806-1-git-send-email-shc_work@mail.ru>
Message-ID: <1403426090-29806-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes definitions which not used anywhere in the driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/clk-imx27.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index ef7001c..fcfb81b 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -18,36 +18,11 @@ static void __iomem *ccm __initdata;
 #define CCM_MPCTL1		(ccm + 0x08)
 #define CCM_SPCTL0		(ccm + 0x0c)
 #define CCM_SPCTL1		(ccm + 0x10)
-#define CCM_OSC26MCTL		(ccm + 0x14)
 #define CCM_PCDR0		(ccm + 0x18)
 #define CCM_PCDR1		(ccm + 0x1c)
 #define CCM_PCCR0		(ccm + 0x20)
 #define CCM_PCCR1		(ccm + 0x24)
 #define CCM_CCSR		(ccm + 0x28)
-#define CCM_PMCTL		(ccm + 0x2c)
-#define CCM_PMCOUNT		(ccm + 0x30)
-#define CCM_WKGDCTL		(ccm + 0x34)
-
-#define CCM_CSCR_UPDATE_DIS	(1 << 31)
-#define CCM_CSCR_SSI2		(1 << 23)
-#define CCM_CSCR_SSI1		(1 << 22)
-#define CCM_CSCR_VPU		(1 << 21)
-#define CCM_CSCR_MSHC           (1 << 20)
-#define CCM_CSCR_SPLLRES        (1 << 19)
-#define CCM_CSCR_MPLLRES        (1 << 18)
-#define CCM_CSCR_SP             (1 << 17)
-#define CCM_CSCR_MCU            (1 << 16)
-#define CCM_CSCR_OSC26MDIV      (1 << 4)
-#define CCM_CSCR_OSC26M         (1 << 3)
-#define CCM_CSCR_FPM            (1 << 2)
-#define CCM_CSCR_SPEN           (1 << 1)
-#define CCM_CSCR_MPEN           (1 << 0)
-
-/* i.MX27 TO 2+ */
-#define CCM_CSCR_ARM_SRC        (1 << 15)
-
-#define CCM_SPCTL1_LF           (1 << 15)
-#define CCM_SPCTL1_BRMO         (1 << 6)
 
 static const char *vpu_sel_clks[] = { "spll", "mpll_main2", };
 static const char *cpu_sel_clks[] = { "mpll_main2", "mpll", };
-- 
1.8.5.5
