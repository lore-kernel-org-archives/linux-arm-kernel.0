From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 09:33:49 +0900
Subject: [PATCH 1/6] ARM: shmobile: smp: Make shmobile_smp_apmu_cpu_shutdown()
 static
In-Reply-To: <cover.1444868660.git.horms+renesas@verge.net.au>
References: <cover.1444868660.git.horms+renesas@verge.net.au>
Message-ID: <54245073431df264fe4715bc7f1bf295a19c40b7.1444868660.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

shmobile_smp_apmu_cpu_shutdown() is used inside platsmp-apmu.c only.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 4e54512bee30..bcf4cc51b926 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -170,7 +170,7 @@ static inline void cpu_enter_lowpower_a15(void)
 	dsb();
 }
 
-void shmobile_smp_apmu_cpu_shutdown(unsigned int cpu)
+static void shmobile_smp_apmu_cpu_shutdown(unsigned int cpu)
 {
 
 	/* Select next sleep mode using the APMU */
-- 
2.1.4
