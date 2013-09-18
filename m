From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 19 Sep 2013 04:50:00 +0900
Subject: [PATCH] ARM: shmobile: Allow build of the MTU2 timer driver
Message-ID: <20130918195000.6075.25025.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Include MTU2 in the list of timer drivers that may
be used on mach-shmobile. This driver has previously
only been used by the SH architecture. With this patch
the MTU2 joins TMU and CMT as timer drivers that may be
used on ARM or SH.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0004/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-09-19 04:17:55.000000000 +0900
@@ -314,6 +314,12 @@ config SH_TIMER_CMT
 	help
 	  This enables build of the CMT timer driver.
 
+config SH_TIMER_MTU2
+	bool "MTU2 timer driver"
+	default y
+	help
+	  This enables build of the MTU2 timer driver.
+
 config SH_TIMER_TMU
 	bool "TMU timer driver"
 	default y
