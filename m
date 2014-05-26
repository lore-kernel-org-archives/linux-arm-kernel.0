From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 26 May 2014 17:01:14 +0200
Subject: [PATCH] ARM: mvebu: mark armada_370_xp_pmsu_idle_prepare() as static
Message-ID: <1401116474-31221-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The armada_370_xp_pmsu_idle_prepare() function is only used internally
to pmsu.c, so there's no reason to not use the static qualifier.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 53a55c8..6e83d32 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -148,7 +148,7 @@ static void armada_370_xp_cpu_resume(void)
 }
 
 /* No locking is needed because we only access per-CPU registers */
-void armada_370_xp_pmsu_idle_prepare(bool deepidle)
+static void armada_370_xp_pmsu_idle_prepare(bool deepidle)
 {
 	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
 	u32 reg;
-- 
1.9.3
