From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Sat, 18 Jun 2016 17:31:06 -0700
Subject: [PATCH v3 3/5] i.MX: system.c: Replace magic numbers
In-Reply-To: <1466296268-27099-1-git-send-email-andrew.smirnov@gmail.com>
References: <1466296268-27099-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <1466296268-27099-6-git-send-email-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace magic numbers used to form L310 Prefetch Control Register value.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/mach-imx/system.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index b153376..7ba9dc8 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -109,7 +109,10 @@ void __init imx_init_l2cache(void)
 	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
 		/* Configure the L2 PREFETCH and POWER registers */
 		val = readl_relaxed(l2x0_base + L310_PREFETCH_CTRL);
-		val |= 0x70800000;
+		val |= L310_PREFETCH_CTRL_DBL_
+			L310_PREFETCH_CTRL_INSTR_PREFETCH |
+			L310_PREFETCH_CTRL_DATA_PREFETCH |
+			L310_PREFETCH_CTRL_DBL_LINEFILL_INCR;
 		writel_relaxed(val, l2x0_base + L310_PREFETCH_CTRL);
 	}
 
-- 
2.5.5
