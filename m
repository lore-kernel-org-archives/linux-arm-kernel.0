From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 22 May 2010 00:44:48 +0300
Subject: [PATCH v2t2 16/17] omap: mailbox: mark some resources as __initdata
In-Reply-To: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
References: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <1274478289-22188-17-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/mailbox.c |    2 +-
 arch/arm/mach-omap2/mailbox.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 7e6aea3..aa661a1 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -144,7 +144,7 @@ struct omap_mbox mbox_dsp_info = {
 struct omap_mbox *omap1_mboxes[] = { &mbox_dsp_info, NULL };
 
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
-static struct resource omap1_mbox_resources[] = {
+static struct resource __initdata omap1_mbox_resources[] = {
 	{
 		.start		= OMAP16XX_MAILBOX_BASE,
 		.end		= OMAP16XX_MAILBOX_BASE, /* to be updated */
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index f230edb..ddaf7f0 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -389,7 +389,7 @@ struct omap_mbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info, NULL };
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2420
-static struct resource omap2_mbox_resources[] = {
+static struct resource __initdata omap2_mbox_resources[] = {
 	{
 		.start		= OMAP24XX_MAILBOX_BASE,
 		.end		= OMAP24XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
@@ -407,7 +407,7 @@ static struct resource omap2_mbox_resources[] = {
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3430
-static struct resource omap3_mbox_resources[] = {
+static struct resource __initdata omap3_mbox_resources[] = {
 	{
 		.start		= OMAP34XX_MAILBOX_BASE,
 		.end		= OMAP34XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
@@ -421,7 +421,7 @@ static struct resource omap3_mbox_resources[] = {
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
-static struct resource omap4_mbox_resources[] = {
+static struct resource __initdata omap4_mbox_resources[] = {
 	{
 		.start          = OMAP44XX_MAILBOX_BASE,
 		.end            = OMAP44XX_MAILBOX_BASE + OMAP4_MBOX_REG_SIZE - 1,
-- 
1.7.1
