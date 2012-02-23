From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 23 Feb 2012 12:28:29 +0530
Subject: [PATCH 1/2] ARM: OMAP: fix section mismatch warning for
 omap4_hotplug_cpu()
In-Reply-To: <1329980310-9007-1-git-send-email-santosh.shilimkar@ti.com>
References: <1329980310-9007-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1329980310-9007-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: arch/arm/mach-omap2/built-in.o(.text+0x8b80):
Section mismatch in reference from the function omap4_hotplug_cpu() to
the function .cpuinit.text:omap_secondary_startup()
The function omap4_hotplug_cpu() references
the function __cpuinit omap_secondary_startup().
This is often because omap4_hotplug_cpu lacks a __cpuinit
annotation or the annotation of omap_secondary_startup is wrong.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 1d5d010..fe9ab7c 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -300,7 +300,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
  * @cpu : CPU ID
  * @power_state: CPU low power state.
  */
-int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
+int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 {
 	unsigned int cpu_state = 0;
 
-- 
1.7.4.1
