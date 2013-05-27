From: sanjay.rawat@linaro.org (Sanjay Singh Rawat)
Date: Mon, 27 May 2013 20:02:45 +0530
Subject: [PATCH 8/8] ARM: PRIMA2: use generic cpu idle function for wfi
In-Reply-To: <1369665166-13049-1-git-send-email-sanjay.rawat@linaro.org>
References: <1369665166-13049-1-git-send-email-sanjay.rawat@linaro.org>
Message-ID: <1369665166-13049-9-git-send-email-sanjay.rawat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use cpu_do_idle for entering the wfi mode.

Signed-off-by: Sanjay Singh Rawat <sanjay.rawat@linaro.org>
---
 arch/arm/mach-prima2/hotplug.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-prima2/hotplug.c b/arch/arm/mach-prima2/hotplug.c
index 0ab2f8b..68d2903 100644
--- a/arch/arm/mach-prima2/hotplug.c
+++ b/arch/arm/mach-prima2/hotplug.c
@@ -16,8 +16,8 @@ static inline void platform_do_lowpower(unsigned int cpu)
 {
 	/* we put the platform to just WFI */
 	for (;;) {
-		__asm__ __volatile__("dsb\n\t" "wfi\n\t"
-			: : : "memory");
+		cpu_do_idle();
+
 		if (pen_release == cpu_logical_map(cpu)) {
 			/*
 			 * OK, proper wakeup, we're done
-- 
1.7.9.5
