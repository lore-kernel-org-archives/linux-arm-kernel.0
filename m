From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 22 Oct 2009 09:21:19 +0200
Subject: msm_sdcc.c: add missing include
Message-ID: <20091022072119.GA3285@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Add missing include for	msm_sdcc compilation.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/include/asm/mach/mmc.h b/arch/arm/include/asm/mach/mmc.h
new file mode 100644
index 0000000..8948dec
--- /dev/null
+++ b/arch/arm/include/asm/mach/mmc.h
@@ -0,0 +1,26 @@
+/*
+ *  arch/arm/include/asm/mach/mmc.h
+ */
+#ifndef ASMARM_MACH_MMC_H
+#define ASMARM_MACH_MMC_H
+
+#include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/sdio_func.h>
+
+struct embedded_sdio_data {
+        struct sdio_cis cis;
+        struct sdio_cccr cccr;
+        struct sdio_embedded_func *funcs;
+        int num_funcs;
+};
+
+struct mmc_platform_data {
+	unsigned int ocr_mask;			/* available voltages */
+	u32 (*translate_vdd)(struct device *, unsigned int);
+	unsigned int (*status)(struct device *);
+	struct embedded_sdio_data *embedded_sdio;
+	int (*register_status_notify)(void (*callback)(int card_present, void *dev_id), void *dev_id);
+};
+
+#endif

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
