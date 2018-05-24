From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 24 May 2018 09:07:00 +0200
Subject: [PATCH v2 10/13] dmaengine: pxa: document pxad_param
In-Reply-To: <20180524070703.11901-1-robert.jarzmik@free.fr>
References: <20180524070703.11901-1-robert.jarzmik@free.fr>
Message-ID: <20180524070703.11901-11-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some documentation for the pxad_param structure, and describe the
contract behind the minimal required priority of a DMA channel.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 include/linux/dma/pxa-dma.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/dma/pxa-dma.h b/include/linux/dma/pxa-dma.h
index e56ec7af4fd7..9fc594f69eff 100644
--- a/include/linux/dma/pxa-dma.h
+++ b/include/linux/dma/pxa-dma.h
@@ -9,6 +9,15 @@ enum pxad_chan_prio {
 	PXAD_PRIO_LOWEST,
 };
 
+/**
+ * struct pxad_param - dma channel request parameters
+ * @drcmr: requestor line number
+ * @prio: minimal mandatory priority of the channel
+ *
+ * If a requested channel is granted, its priority will be at least @prio,
+ * ie. if PXAD_PRIO_LOW is required, the requested channel will be either
+ * PXAD_PRIO_LOW, PXAD_PRIO_NORMAL or PXAD_PRIO_HIGHEST.
+ */
 struct pxad_param {
 	unsigned int drcmr;
 	enum pxad_chan_prio prio;
-- 
2.11.0
