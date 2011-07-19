From: mturquette@ti.com (Mike Turquette)
Date: Tue, 19 Jul 2011 16:47:11 -0700
Subject: [PATCH 2/2] OMAP4: Kconfig: remove hotplug control for CPU0
Message-ID: <mailman.27.1311286727.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On OMAP4, CPU0 cannot be dynamically offlined through the usual CPU
hotplug mechanism due to a variety of constraints.  It is treated as a
special "master" CPU for these reasons.

Select HOTPLUG_CPU_MASTER to prevent creation of the hotplug control
entry in sysfs.

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 4ae6257..b6199e3 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -51,6 +51,7 @@ config ARCH_OMAP4
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
 	select USB_ARCH_HAS_EHCI
+	select HOTPLUG_CPU_MASTER

 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
--=20
1.7.4.1
