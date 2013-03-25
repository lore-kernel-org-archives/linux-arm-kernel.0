From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 25 Mar 2013 15:35:06 +0530
Subject: [PATCH v2 14/18] ARM: OMAP4: CPUidle: Make C-state description field
 more precise
In-Reply-To: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1364205910-32392-15-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is useful to know the CPU power state along with MPUSS power state
in a supported C-state. Since the data is available via sysfs, one can
avoid scrolling the source code for precise construction of C-state.

Reported-by: Nishanth Menon <nm@ti.com>
Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 908114d..b8a22f0 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -181,7 +181,7 @@ static struct cpuidle_driver omap4_idle_driver = {
 			.flags = CPUIDLE_FLAG_TIME_VALID,
 			.enter = omap4_enter_idle_simple,
 			.name = "C1",
-			.desc = "MPUSS ON"
+			.desc = "CPUx ON, MPUSS ON"
 		},
 		{
 			/* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
@@ -190,7 +190,7 @@ static struct cpuidle_driver omap4_idle_driver = {
 			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
 			.enter = omap4_enter_idle_coupled,
 			.name = "C2",
-			.desc = "MPUSS CSWR",
+			.desc = "CPUx OFF, MPUSS CSWR",
 		},
 		{
 			/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
@@ -199,7 +199,7 @@ static struct cpuidle_driver omap4_idle_driver = {
 			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
 			.enter = omap4_enter_idle_coupled,
 			.name = "C3",
-			.desc = "MPUSS OSWR",
+			.desc = "CPUx OFF, MPUSS OSWR",
 		},
 	},
 	.state_count = ARRAY_SIZE(omap4_idle_data),
-- 
1.7.9.5
