From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 28 Feb 2011 11:00:28 +0100
Subject: [PATCH 7/8] ARM i.MX5: increase dma consistent size for IPU support
In-Reply-To: <1298887229-7987-1-git-send-email-s.hauer@pengutronix.de>
References: <1298887229-7987-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1298887229-7987-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/memory.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
index 8386140..fd3444c 100644
--- a/arch/arm/plat-mxc/include/mach/memory.h
+++ b/arch/arm/plat-mxc/include/mach/memory.h
@@ -43,7 +43,8 @@
 # endif
 #endif
 
-#if defined(CONFIG_MX3_VIDEO)
+#if defined(CONFIG_MX3_VIDEO) || defined(CONFIG_FB_IMX_IPU_V3) || \
+	defined(CONFIG_FB_IMX_IPU_V3_MODULE)
 /*
  * Increase size of DMA-consistent memory region.
  * This is required for mx3 camera driver to capture at least two QXGA frames.
-- 
1.7.2.3
