From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 12 May 2012 13:37:07 +0100
Subject: [PATCH 4/4] ARM: orion5x: remove PM dependency from ts78xx
In-Reply-To: <1336826227-17020-1-git-send-email-alex@digriz.org.uk>
References: <1336826227-17020-1-git-send-email-alex@digriz.org.uk>
Message-ID: <1336826227-17020-5-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move ts78xx_fpga from /sys/power to /sys/firmware so that
we can remove the PM dependency.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/mach-orion5x/Kconfig        |    1 -
 arch/arm/mach-orion5x/ts78xx-setup.c |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index 6604fc6..0673f0c 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -86,7 +86,6 @@ config MACH_WRT350N_V2
 
 config MACH_TS78XX
 	bool "Technologic Systems TS-78xx"
-	select PM
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Technologic Systems TS-78xx platform.
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 5d0aacd..bfc8696 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -609,7 +609,7 @@ static void __init ts78xx_init(void)
 	/* FPGA init */
 	ts78xx_fpga_devices_zero_init();
 	ret = ts78xx_fpga_load();
-	ret = sysfs_create_file(power_kobj, &ts78xx_fpga_attr.attr);
+	ret = sysfs_create_file(firmware_kobj, &ts78xx_fpga_attr.attr);
 	if (ret)
 		pr_err("sysfs_create_file failed: %d\n", ret);
 }
-- 
1.7.10
