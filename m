From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 14 May 2010 18:01:48 +0300
Subject: [PATCH v2 15/17] omap: mailbox: don't export unecessary symbols
In-Reply-To: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <1273849310-32169-16-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/mailbox.c |    1 -
 arch/arm/mach-omap2/mailbox.c |    3 ---
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index f6376b9..7e6aea3 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -140,7 +140,6 @@ struct omap_mbox mbox_dsp_info = {
 	.ops	= &omap1_mbox_ops,
 	.priv	= &omap1_mbox_dsp_priv,
 };
-EXPORT_SYMBOL(mbox_dsp_info);
 
 struct omap_mbox *omap1_mboxes[] = { &mbox_dsp_info, NULL };
 
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index c1a732e..f230edb 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -306,7 +306,6 @@ struct omap_mbox mbox_dsp_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_dsp_priv,
 };
-EXPORT_SYMBOL(mbox_dsp_info);
 #endif
 
 #if defined(CONFIG_ARCH_OMAP3430)
@@ -363,7 +362,6 @@ struct omap_mbox mbox_1_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_1_priv,
 };
-EXPORT_SYMBOL(mbox_1_info);
 
 static struct omap_mbox2_priv omap2_mbox_2_priv = {
 	.tx_fifo = {
@@ -386,7 +384,6 @@ struct omap_mbox mbox_2_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_2_priv,
 };
-EXPORT_SYMBOL(mbox_2_info);
 
 struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info, NULL };
 #endif
-- 
1.7.1
