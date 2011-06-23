From: kosaki.motohiro@jp.fujitsu.com (KOSAKI Motohiro)
Date: Thu, 23 Jun 2011 17:28:28 +0900
Subject: [PATCH 1/3] arm,tegra: replace cpu_set() with modern api
Message-ID: <4E02F92C.7070203@jp.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpu_set() is marked as obsolete cpumask function and we plan to
remove it in future.

This patch replace it with modern cpumask function.

Signed-off-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: Colin Cross <ccross@android.com>
Cc: Erik Gilling <konkers@android.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-tegra/platsmp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index b8ae3c9..468523c 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -122,7 +122,7 @@ void __init smp_init_cpus(void)
 	}

 	for (i = 0; i < ncores; i++)
-		cpu_set(i, cpu_possible_map);
+		set_cpu_possible(i, true);

 	set_smp_cross_call(gic_raise_softirq);
 }
-- 
1.7.3.1
