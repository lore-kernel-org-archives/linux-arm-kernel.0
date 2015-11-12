From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Nov 2015 12:06:06 -0600
Subject: [PATCH] arm: omap2: Kconfig: select TWD and global timer on AM43xx
 devices
Message-ID: <1447351566-2328-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to tell the kernel that AM437x has
TWD and global timers.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Hi Tony,

now that all dependencies are in place, we can
finally enable twd and global_timer for AM437x.

cheers

 arch/arm/mach-omap2/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 5076d3f334d2..bb3daf0fa7f7 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -65,6 +65,9 @@ config SOC_AM43XX
 	select MACH_OMAP_GENERIC
 	select MIGHT_HAVE_CACHE_L2X0
 	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD
+	select ARM_GLOBAL_TIMER
+	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 
 config SOC_DRA7XX
 	bool "TI DRA7XX"
-- 
2.6.2
