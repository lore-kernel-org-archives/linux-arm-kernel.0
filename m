From: tony@atomide.com (Tony Lindgren)
Date: Tue, 02 Feb 2010 18:26:04 -0800
Subject: [PATCH 3/9] ARCH OMAP : enable ARCH_HAS_HOLES_MEMORYMODEL for OMAP
In-Reply-To: <20100203022318.26347.34734.stgit@baageli.muru.com>
References: <20100203022318.26347.34734.stgit@baageli.muru.com>
Message-ID: <20100203022604.26347.98750.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sriram <srk@ti.com>

OMAP platforms(like OMAP3530) include DSP or other co-processors
for media acceleration. when carving out memory for the
accelerators we can end up creating a hole in the memory map
of sort:
<kernel memory><hole(memory for accelerator)><kernel memory>

To handle such a memory configuration ARCH_HAS_HOLES_MEMORYMODEL
has to be enabled. For further information refer discussion at:
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg15262.html.

Signed-off-by: Sriramakrishnan <srk@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c33ca8..184a6bd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -702,6 +702,7 @@ config ARCH_OMAP
 	select ARCH_HAS_CPUFREQ
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
+	select ARCH_HAS_HOLES_MEMORYMODEL
 	help
 	  Support for TI's OMAP platform (OMAP1 and OMAP2).
 
