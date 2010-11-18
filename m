From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Thu, 18 Nov 2010 19:59:48 +0200
Subject: [PATCH] arm: omap1: mbox: make variables static
In-Reply-To: <1290103191-360-1-git-send-email-aaro.koskinen@nokia.com>
References: <1290103191-360-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <1290103191-360-4-git-send-email-aaro.koskinen@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make some variables static to get rid of the following warnings:

	arch/arm/mach-omap1/mailbox.c:136:18: warning: symbol 'mbox_dsp_info' was not declared. Should it be static?
	arch/arm/mach-omap1/mailbox.c:142:18: warning: symbol 'omap1_mboxes' was not declared. Should it be static?

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap1/mailbox.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 1a85a42..12d6880 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -133,13 +133,13 @@ static struct omap_mbox1_priv omap1_mbox_dsp_priv = {
 	},
 };
 
-struct omap_mbox mbox_dsp_info = {
+static struct omap_mbox mbox_dsp_info = {
 	.name	= "dsp",
 	.ops	= &omap1_mbox_ops,
 	.priv	= &omap1_mbox_dsp_priv,
 };
 
-struct omap_mbox *omap1_mboxes[] = { &mbox_dsp_info, NULL };
+static struct omap_mbox *omap1_mboxes[] = { &mbox_dsp_info, NULL };
 
 static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 {
-- 
1.5.6.5
