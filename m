From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 22 May 2010 20:14:16 +0300
Subject: [PATCH v3 05/14] omap: mailbox: use correct config for omap1
In-Reply-To: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <1274548465-20208-6-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_OMAP_DSP is not in mainline, CONFIG_OMAP_MBOX_FWK is.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 462b59c..da796f2 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -63,7 +63,7 @@ static void omap_init_rtc(void)
 static inline void omap_init_rtc(void) {}
 #endif
 
-#if defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
+#if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
 
 #if defined(CONFIG_ARCH_OMAP15XX)
 #  define OMAP1_MBOX_SIZE	0x23
-- 
1.7.1
