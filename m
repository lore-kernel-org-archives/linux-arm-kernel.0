From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sat, 15 Nov 2014 20:53:38 -0300
Subject: [PATCH RESEND] ARM: sunxi: make sun6i SMP ops static
Message-ID: <1416095618-2900-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun6i SMP ops are currently not marked as static, as reported by
sparse. Let's mark it as such.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

Here's an oldish patch that never made it to mainline. I rediscovered it
today while I was cleaning up stuff and running a sparse build of -rc4.

Cheers!

Emilio

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
2.1.3
