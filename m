From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 17 Apr 2015 11:50:22 +0100
Subject: [PATCH 4/5] ARM: sti: Always enable CLKSRC_ST_LPC_CLOCK
In-Reply-To: <1429267823-8879-1-git-send-email-peter.griffin@linaro.org>
References: <1429267823-8879-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1429267823-8879-5-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If available on the SoC we wish to use st_lpc clksrc
so that cpufreq can operate without effecting sched_clock.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/mach-sti/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index 3b1ac46..48767d3 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -2,6 +2,7 @@ menuconfig ARCH_STI
 	bool "STMicroelectronics Consumer Electronics SOCs" if ARCH_MULTI_V7
 	select ARM_GIC
 	select ARM_GLOBAL_TIMER
+	select CLKSRC_ST_LPC_CLOCK
 	select PINCTRL
 	select PINCTRL_ST
 	select MFD_SYSCON
@@ -15,9 +16,9 @@ menuconfig ARCH_STI
 	select PL310_ERRATA_769419 if CACHE_L2X0
 	select RESET_CONTROLLER
 	help
-	  Include support for STiH41x SOCs like STiH415/416 using the device tree
-	  for discovery
-	  More information at Documentation/arm/STiH41x and
+	  Include support for STiH4xx SOCs like STiH415/416 and stih407/10 family
+	  using the device tree for discovery
+	  More information at Documentation/arm/sti/ and
 	  at Documentation/devicetree
 
 
-- 
1.9.1
