From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:32:26 +0900
Subject: [PATCH 16/43] ARM: shmobile: Make EMEV2 setup functions static
In-Reply-To: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
References: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363609973-31086-17-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Adjust emev2_init_delay() and emev2_add_standard_devices_dt()
to become static. They are not used outside this file anyway.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-emev2.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index 47662a5..e4545c1 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -404,7 +404,7 @@ void __init emev2_add_standard_devices(void)
 			     ARRAY_SIZE(emev2_late_devices));
 }
 
-void __init emev2_init_delay(void)
+static void __init emev2_init_delay(void)
 {
 	shmobile_setup_delay(533, 1, 3); /* Cortex-A9 @ 533MHz */
 }
@@ -439,7 +439,7 @@ static const struct of_dev_auxdata emev2_auxdata_lookup[] __initconst = {
 	{ }
 };
 
-void __init emev2_add_standard_devices_dt(void)
+static void __init emev2_add_standard_devices_dt(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     emev2_auxdata_lookup, NULL);
-- 
1.7.10.4
