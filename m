From: dennis.obrien@eqware.net (Dennis O'Brien)
Date: Sat, 10 Oct 2009 15:08:52 +0800
Subject: [PATCH] [ARM] pxa: workaround errata #37 by not using half
Message-ID: <mailman.70.1255167033.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

turbo switching

PXA27x Errata #37 implies system will hang when switching into or out of
half turbo (HT bit in CLKCFG) mode, workaround this by not using it.

Signed-off-by: Dennis O'Brien <dennis.obrien@eqware.net>
Cc: stable-2.6.31 <stable@kernel.org>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/cpufreq-pxa2xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
index 3a8ee22..983cc8c 100644
--- a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
+++ b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
@@ -155,7 +155,7 @@ MODULE_PARM_DESC(pxa255_turbo_table, "Selects the
frequency table (0 = run table

 static pxa_freqs_t pxa27x_freqs[] = {
 	{104000, 104000, PXA27x_CCCR(1,	 8, 2), 0, CCLKCFG2(1, 0, 1),
900000, 1705000 },
-	{156000, 104000, PXA27x_CCCR(1,	 8, 6), 0, CCLKCFG2(1, 1, 1),
1000000, 1705000 },
+	{156000, 104000, PXA27x_CCCR(1,	 8, 3), 0, CCLKCFG2(1, 0, 1),
1000000, 1705000 },
 	{208000, 208000, PXA27x_CCCR(0, 16, 2), 1, CCLKCFG2(0, 0, 1),
1180000, 1705000 },
 	{312000, 208000, PXA27x_CCCR(1, 16, 3), 1, CCLKCFG2(1, 0, 1),
1250000, 1705000 },
 	{416000, 208000, PXA27x_CCCR(1, 16, 4), 1, CCLKCFG2(1, 0, 1),
1350000, 1705000 },
-- 
1.6.3.3
