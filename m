From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 13:36:12 +0900
Subject: [PATCH 12/18] ARM: rockchip: use const and __initconst for
 smp_operations
In-Reply-To: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440390978-22796-13-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smp_operations structure is not over-written, so add const
qualifier and replace __initdata with __initconst.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-rockchip/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 3e7a4b7..938888f 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -340,7 +340,7 @@ static void rockchip_cpu_die(unsigned int cpu)
 }
 #endif
 
-static struct smp_operations rockchip_smp_ops __initdata = {
+static const struct smp_operations rockchip_smp_ops __initconst = {
 	.smp_prepare_cpus	= rockchip_smp_prepare_cpus,
 	.smp_boot_secondary	= rockchip_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
-- 
1.9.1
