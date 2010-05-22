From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 22 May 2010 20:14:15 +0300
Subject: [PATCH v3 04/14] omap: mailbox: 2420 should be detected at run-time
In-Reply-To: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <1274548465-20208-5-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/mailbox.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index edcfec6..f67cb2c 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -455,7 +455,8 @@ err_dsp:
 static int __devexit omap2_mbox_remove(struct platform_device *pdev)
 {
 #if defined(CONFIG_ARCH_OMAP2420)
-	omap_mbox_unregister(&mbox_iva_info);
+	if (cpu_is_omap2420())
+		omap_mbox_unregister(&mbox_iva_info);
 #endif
 
 	if (cpu_is_omap44xx()) {
-- 
1.7.1
