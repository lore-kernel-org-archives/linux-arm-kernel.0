From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:41:18 +0900
Subject: [PATCH] ARM: shmobile: apmu: silence build warnings
In-Reply-To: <cover.1437725206.git.horms+renesas@verge.net.au>
References: <cover.1437725206.git.horms+renesas@verge.net.au>
Message-ID: <151dd346a2dadaa151d5110553e3fb08774c888e.1437725206.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

With shmobile_defconfig but SMP=n && SUSPEND=n, I get:

arch/arm/mach-shmobile/platsmp-apmu.c:49:12: warning: 'apmu_power_off' defined but not used [-Wunused-function]
arch/arm/mach-shmobile/platsmp-apmu.c:70:12: warning: 'apmu_wrap' defined but not used [-Wunused-function]

Annotate those functions like the functions around it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index b0790fc32282..4e54512bee30 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -46,7 +46,7 @@ static int __maybe_unused apmu_power_on(void __iomem *p, int bit)
 	return 0;
 }
 
-static int apmu_power_off(void __iomem *p, int bit)
+static int __maybe_unused apmu_power_off(void __iomem *p, int bit)
 {
 	/* request Core Standby for next WFI */
 	writel_relaxed(3, p + CPUNCR_OFFS(bit));
@@ -67,7 +67,7 @@ static int __maybe_unused apmu_power_off_poll(void __iomem *p, int bit)
 	return 0;
 }
 
-static int apmu_wrap(int cpu, int (*fn)(void __iomem *p, int cpu))
+static int __maybe_unused apmu_wrap(int cpu, int (*fn)(void __iomem *p, int cpu))
 {
 	void __iomem *p = apmu_cpus[cpu].iomem;
 
-- 
2.1.4
