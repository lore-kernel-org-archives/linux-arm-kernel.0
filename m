From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  9 Feb 2010 11:25:31 +0100
Subject: [PATCH 1/3] add ssi header file
In-Reply-To: <1265711133-7587-1-git-send-email-s.hauer@pengutronix.de>
References: <1265711133-7587-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1265711133-7587-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/ssi.h |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/ssi.h

diff --git a/arch/arm/plat-mxc/include/mach/ssi.h b/arch/arm/plat-mxc/include/mach/ssi.h
new file mode 100644
index 0000000..c34ded5
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/ssi.h
@@ -0,0 +1,18 @@
+#ifndef __MACH_SSI_H
+#define __MACH_SSI_H
+
+struct snd_ac97;
+
+extern unsigned char imx_ssi_fiq_start, imx_ssi_fiq_end;
+extern unsigned long imx_ssi_fiq_base, imx_ssi_fiq_tx_buffer, imx_ssi_fiq_rx_buffer;
+
+struct imx_ssi_platform_data {
+	unsigned int flags;
+#define IMX_SSI_DMA            (1 << 0)
+#define IMX_SSI_USE_AC97       (1 << 1)
+	void (*ac97_reset) (struct snd_ac97 *ac97);
+	void (*ac97_warm_reset)(struct snd_ac97 *ac97);
+};
+
+#endif /* __MACH_SSI_H */
+
-- 
1.6.6
