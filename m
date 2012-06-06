From: tony@atomide.com (Tony Lindgren)
Date: Wed, 06 Jun 2012 01:22:50 -0700
Subject: [PATCH 3/3] ARM: OMAP2+: Fix compile for CONFIG_TIDSPBRIDGE
 platform init code
In-Reply-To: <20120606082156.727.42730.stgit@muffinssi.local>
References: <20120606082156.727.42730.stgit@muffinssi.local>
Message-ID: <20120606082250.727.88234.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7f28427b (ARM: OMAP2+: Move omap_dsp_reserve_sdram_memblock() to mach-omap2)
moved DSP platform init code, but failed to include memblock.h causing:

arch/arm/mach-omap2/dsp.c: In function 'omap_dsp_reserve_sdram_memblock':
arch/arm/mach-omap2/dsp.c:58: error: implicit declaration of function 'arm_memblock_steal'

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/dsp.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/dsp.c b/arch/arm/mach-omap2/dsp.c
index 845309f..88ffa1e 100644
--- a/arch/arm/mach-omap2/dsp.c
+++ b/arch/arm/mach-omap2/dsp.c
@@ -20,6 +20,9 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+
+#include <asm/memblock.h>
+
 #include "cm2xxx_3xxx.h"
 #include "prm2xxx_3xxx.h"
 #ifdef CONFIG_BRIDGE_DVFS
