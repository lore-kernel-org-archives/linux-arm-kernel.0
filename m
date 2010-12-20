From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 20 Dec 2010 11:48:46 +0100
Subject: [PATCH 8/9] ARM i.MX5: increase dma consistent size for IPU support
In-Reply-To: <1292842127-21406-1-git-send-email-s.hauer@pengutronix.de>
References: <1292842127-21406-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1292842127-21406-9-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/memory.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
index 9a9a000..987b42a 100644
--- a/arch/arm/plat-mxc/include/mach/memory.h
+++ b/arch/arm/plat-mxc/include/mach/memory.h
@@ -40,7 +40,8 @@
 # endif
 #endif
 
-#if defined(CONFIG_MX3_VIDEO)
+#if defined(CONFIG_MX3_VIDEO) || defined(CONFIG_MFD_IMX_IPU_V3) || \
+	defined(CONFIG_MFD_IMX_IPU_V3_MODULE)
 /*
  * Increase size of DMA-consistent memory region.
  * This is required for mx3 camera driver to capture at least two QXGA frames.
-- 
1.7.2.3
