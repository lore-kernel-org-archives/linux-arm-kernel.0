From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 10 Dec 2016 16:16:02 +0530
Subject: [PATCH v2 3/3] ARM: EXYNOS: add CPU_METHOD_OF_DECLARE for exynos SoCs
In-Reply-To: <1481366762-26413-1-git-send-email-pankaj.dubey@samsung.com>
References: <1481366762-26413-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1481366762-26413-4-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CPU_METHOD_OF_DECLARE to use enable_method property of
cpus node. To keep compatibility with older DTBs lets keep
older method of registering smp_ops via machine_descriptor.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 94405c7..43eec10 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -474,3 +474,5 @@ const struct smp_operations exynos_smp_ops __initconst = {
 	.cpu_die		= exynos_cpu_die,
 #endif
 };
+
+CPU_METHOD_OF_DECLARE(exynos_smp, "samsung,exynos-smp", &exynos_smp_ops);
-- 
2.7.4
