From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 07 Nov 2013 08:21:20 +0900
Subject: [PATCH 02/04] ARM: shmobile: Use ->init_late() in shared EMEV2 case
In-Reply-To: <20131106232102.8081.20523.sendpatchset@w520>
References: <20131106232102.8081.20523.sendpatchset@w520>
Message-ID: <20131106232120.8081.76012.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Hook up shmobile_init_late() to enable various
code such as suspend-to-RAM and CPUIdle.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-emev2.c |    1 +
 1 file changed, 1 insertion(+)

--- 0004/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-11-05 15:58:30.000000000 +0900
@@ -79,6 +79,7 @@ DT_MACHINE_START(EMEV2_DT, "Generic Emma
 	.map_io		= emev2_map_io,
 	.init_early	= emev2_init_delay,
 	.init_machine	= emev2_add_standard_devices_dt,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= emev2_boards_compat_dt,
 MACHINE_END
 
