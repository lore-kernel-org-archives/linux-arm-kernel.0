From: balbi@ti.com (Felipe Balbi)
Date: Wed, 12 Aug 2015 14:56:55 -0500
Subject: [PATCH-next 3/4] arm: omap2: Kconfig: select TWD and global timer on
 AM43xx devices
In-Reply-To: <1439409416-32673-1-git-send-email-balbi@ti.com>
References: <1439409416-32673-1-git-send-email-balbi@ti.com>
Message-ID: <1439409416-32673-4-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to tell the kernel that AM437x has
TWD and global timers.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 07d2e100caab..88ef10b2d415 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -63,6 +63,9 @@ config SOC_AM43XX
 	select MACH_OMAP_GENERIC
 	select MIGHT_HAVE_CACHE_L2X0
 	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD
+	select ARM_GLOBAL_TIMER
+	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 
 config SOC_DRA7XX
 	bool "TI DRA7XX"
-- 
2.5.0
