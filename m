From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 23 Nov 2014 13:54:41 +0100
Subject: [PATCH 3/5] ARM: sunxi: Add "allwinner,sun6i-a31s" to mach-sunxi
In-Reply-To: <1416747283-13489-1-git-send-email-hdegoede@redhat.com>
References: <1416747283-13489-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1416747283-13489-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So fat the A31s is 100% compatible with the A31, still lets do the same
as what we've done for the A13 / A10s and give it its own compatible string,
in case need to differentiate later.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/mach-sunxi/platsmp.c | 3 ++-
 arch/arm/mach-sunxi/sunxi.c   | 1 +
 drivers/clk/sunxi/clk-sunxi.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
index c53077b..8601491 100644
--- a/arch/arm/mach-sunxi/platsmp.c
+++ b/arch/arm/mach-sunxi/platsmp.c
@@ -120,4 +120,5 @@ struct smp_operations sun6i_smp_ops __initdata = {
 	.smp_prepare_cpus	= sun6i_smp_prepare_cpus,
 	.smp_boot_secondary	= sun6i_smp_boot_secondary,
 };
-CPU_METHOD_OF_DECLARE(sun6i_smp, "allwinner,sun6i-a31", &sun6i_smp_ops);
+CPU_METHOD_OF_DECLARE(sun6i_a31_smp, "allwinner,sun6i-a31", &sun6i_smp_ops);
+CPU_METHOD_OF_DECLARE(sun6i_a31s_smp, "allwinner,sun6i-a31s", &sun6i_smp_ops);
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index d7598ae..2d9ca5b 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -29,6 +29,7 @@ MACHINE_END
 
 static const char * const sun6i_board_dt_compat[] = {
 	"allwinner,sun6i-a31",
+	"allwinner,sun6i-a31s",
 	NULL,
 };
 
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index f19e0f9..3577f4c 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1200,4 +1200,5 @@ static void __init sun6i_init_clocks(struct device_node *node)
 			  ARRAY_SIZE(sun6i_critical_clocks));
 }
 CLK_OF_DECLARE(sun6i_a31_clk_init, "allwinner,sun6i-a31", sun6i_init_clocks);
+CLK_OF_DECLARE(sun6i_a31s_clk_init, "allwinner,sun6i-a31s", sun6i_init_clocks);
 CLK_OF_DECLARE(sun8i_a23_clk_init, "allwinner,sun8i-a23", sun6i_init_clocks);
-- 
2.1.0
