From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Thu, 31 Jul 2014 18:28:06 -0300
Subject: [PATCH 3/9] ARM: sunxi: make sun6i SMP ops static
In-Reply-To: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
References: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1406842092-25207-4-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun6i SMP ops are currently not marked as static, as reported by
sparse. Let's mark it as such.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/mach-sunxi/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
index c53077b..e44d028 100644
--- a/arch/arm/mach-sunxi/platsmp.c
+++ b/arch/arm/mach-sunxi/platsmp.c
@@ -116,7 +116,7 @@ static int sun6i_smp_boot_secondary(unsigned int cpu,
 	return 0;
 }
 
-struct smp_operations sun6i_smp_ops __initdata = {
+static struct smp_operations sun6i_smp_ops __initdata = {
 	.smp_prepare_cpus	= sun6i_smp_prepare_cpus,
 	.smp_boot_secondary	= sun6i_smp_boot_secondary,
 };
-- 
2.0.3
