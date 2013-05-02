From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 17:16:16 +0200
Subject: [PATCH, RFC 12/22] thermal: cpu_cooling: fix stub function
In-Reply-To: <1367507786-505303-1-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
Message-ID: <1367507786-505303-13-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function stub for cpufreq_cooling_get_level introduced
in 57df81069 "Thermal: exynos: fix cooling state translation"
is not syntactically correct C and needs to be fixed to avoid
this error:

In file included from drivers/thermal/db8500_thermal.c:20:0:
 include/linux/cpu_cooling.h: In function 'cpufreq_cooling_get_level':
include/linux/cpu_cooling.h:57:1:
 error: parameter name omitted  unsigned long cpufreq_cooling_get_level(unsigned int, unsigned int)  ^
 include/linux/cpu_cooling.h:57:1: error: parameter name omitted

Cc: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Amit Daniel kachhap <amit.daniel@samsung.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/cpu_cooling.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index 282e270..cf03111 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -54,7 +54,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 	return;
 }
 static inline
-unsigned long cpufreq_cooling_get_level(unsigned int, unsigned int)
+unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq)
 {
 	return THERMAL_CSTATE_INVALID;
 }
-- 
1.8.1.2
