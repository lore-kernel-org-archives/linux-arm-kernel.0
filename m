From: tixy@yxit.co.uk (Tixy)
Date: Mon, 22 Aug 2011 12:05:50 +0100
Subject: [PATCH 06/12] ARM: mxc: Setup consistent dma size at boot time
In-Reply-To: <20110819170007.GT31404@pengutronix.de>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
	<1312813712-22808-7-git-send-email-tixy@yxit.co.uk>
	<20110808164731.GP31404@pengutronix.de>
	<alpine.LFD.2.00.1108172309450.20358@xanadu.home>
	<1313655216.2254.9.camel@computer2>
	<20110818185128.GQ31404@pengutronix.de>
	<1313744901.28978.16.camel@computer2>
	<20110819170007.GT31404@pengutronix.de>
Message-ID: <1314011150.3604.9.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha, does the following revised patch gain receive your
Acked-by?...

From: Jon Medhurst <tixy@yxit.co.uk>

All in tree MX boards using video use memblock_* functions to get their coherent
dma space for the camera, so there is no need to increase CONSISTENT_DMA_SIZE
beyond the default and we can simply remove the defines which do this.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
CC: Sascha Hauer <kernel@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/memory.h |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
index 11be5cd..3ec84b9 100644
--- a/arch/arm/plat-mxc/include/mach/memory.h
+++ b/arch/arm/plat-mxc/include/mach/memory.h
@@ -40,19 +40,4 @@
 # endif
 #endif
 
-#if defined(CONFIG_MX3_VIDEO)
-/*
- * Increase size of DMA-consistent memory region.
- * This is required for mx3 camera driver to capture at least two QXGA frames.
- */
-#define CONSISTENT_DMA_SIZE SZ_8M
-
-#elif defined(CONFIG_MX1_VIDEO) || defined(CONFIG_VIDEO_MX2_HOSTSUPPORT)
-/*
- * Increase size of DMA-consistent memory region.
- * This is required for i.MX camera driver to capture at least four VGA frames.
- */
-#define CONSISTENT_DMA_SIZE SZ_4M
-#endif /* CONFIG_MX1_VIDEO || CONFIG_VIDEO_MX2_HOSTSUPPORT */
-
 #endif /* __ASM_ARCH_MXC_MEMORY_H__ */
-- 
1.7.2.5
