From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Oct 2009 15:12:28 -0700
Subject: [PATCH 06/10] omap: Fix detection of n8x0
In-Reply-To: <20091022221013.27408.443.stgit@localhost>
References: <20091022221013.27408.443.stgit@localhost>
Message-ID: <20091022221228.27408.66649.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise the machine_is_nokia_n8*() does not work.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 75b1c7e..aad194f 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -73,9 +73,21 @@ config MACH_OMAP_3430SDP
 	bool "OMAP 3430 SDP board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+config MACH_NOKIA_N800
+       bool
+
+config MACH_NOKIA_N810
+       bool
+
+config MACH_NOKIA_N810_WIMAX
+       bool
+
 config MACH_NOKIA_N8X0
 	bool "Nokia N800/N810"
 	depends on ARCH_OMAP2420
+	select MACH_NOKIA_N800
+	select MACH_NOKIA_N810
+	select MACH_NOKIA_N810_WIMAX
 
 config MACH_NOKIA_RX51
 	bool "Nokia RX-51 board"
