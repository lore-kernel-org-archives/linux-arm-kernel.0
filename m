From: nm@ti.com (Nishanth Menon)
Date: Wed, 25 Mar 2015 17:12:24 -0500
Subject: [PATCH] ARM: DRA7: Enable Cortex A15 errata 798181
Message-ID: <1427321544-5150-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM errata 798181 is applicable for DRA7 based devices. So enable
the same in the build. Errata extract and workaround information
is as below.

On Cortex-A15 (r0p0..r3p2) the TLBI*IS/DSB operations are not
adequately shooting down all use of the old entries. The
ARM_ERRATA_798181 option enables the Linux kernel workaround
for this erratum which sends an IPI to the CPUs that are running
the same ASID as the one being invalidated.

Reported-by: Praneeth Kumar Bajjuri <praneeth@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 2b8e47788062..1f78709adb05 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -69,6 +69,7 @@ config SOC_DRA7XX
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
 	select IRQ_CROSSBAR
+	select ARM_ERRATA_798181 if SMP
 
 config ARCH_OMAP2PLUS
 	bool
-- 
1.7.9.5
