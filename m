From: sanjay.rawat@linaro.org (Sanjay Singh Rawat)
Date: Mon, 27 May 2013 20:02:44 +0530
Subject: [PATCH 7/8] ARM: msm: use generic cpu idle function for wfi
In-Reply-To: <1369665166-13049-1-git-send-email-sanjay.rawat@linaro.org>
References: <1369665166-13049-1-git-send-email-sanjay.rawat@linaro.org>
Message-ID: <1369665166-13049-8-git-send-email-sanjay.rawat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use cpu_do_idle for entering the wfi mode.

Signed-off-by: Sanjay Singh Rawat <sanjay.rawat@linaro.org>
---
 arch/arm/mach-msm/hotplug.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-msm/hotplug.c b/arch/arm/mach-msm/hotplug.c
index 326a872..1b03e5f 100644
--- a/arch/arm/mach-msm/hotplug.c
+++ b/arch/arm/mach-msm/hotplug.c
@@ -26,13 +26,8 @@ static inline void platform_do_lowpower(unsigned int cpu)
 {
 	/* Just enter wfi for now. TODO: Properly shut off the cpu. */
 	for (;;) {
-		/*
-		 * here's the WFI
-		 */
-		asm("wfi"
-		    :
-		    :
-		    : "memory", "cc");
+		/* enter WFI mode */
+		cpu_do_idle();
 
 		if (pen_release == cpu_logical_map(cpu)) {
 			/*
-- 
1.7.9.5
