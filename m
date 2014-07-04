From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 04 Jul 2014 19:48:14 +0200
Subject: [PATCH 14/19] ARM: s5pv210: Register cpufreq platform device
In-Reply-To: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
Message-ID: <1404496099-26708-15-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-s5pv210/s5pv210.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-s5pv210/s5pv210.c b/arch/arm/mach-s5pv210/s5pv210.c
index 35db1ce..53feff3 100644
--- a/arch/arm/mach-s5pv210/s5pv210.c
+++ b/arch/arm/mach-s5pv210/s5pv210.c
@@ -59,6 +59,7 @@ static void s5pv210_dt_restart(enum reboot_mode mode, const char *cmd)
 
 static void __init s5pv210_dt_init_late(void)
 {
+	platform_device_register_simple("s5pv210-cpufreq", -1, NULL, 0);
 	s5pv210_pm_init();
 }
 
-- 
1.9.3
