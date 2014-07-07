From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 07 Jul 2014 10:53:11 +0900
Subject: [PATCH] ARM: Use 'model' property to set machine_name from Device Tree
Message-ID: <1404697991-32191-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch use 'model' property from Device Tree to set machine_name.
The arm64 has already got the machine_name from Device Tree.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/kernel/setup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 8a16ee5..698616f 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -878,7 +878,11 @@ void __init setup_arch(char **cmdline_p)
 	if (!mdesc)
 		mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
 	machine_desc = mdesc;
+#if CONFIG_OF
+	machine_name = of_flat_dt_get_machine_name();
+#else
 	machine_name = mdesc->name;
+#endif
 
 	if (mdesc->reboot_mode != REBOOT_HARD)
 		reboot_mode = mdesc->reboot_mode;
-- 
1.8.0
