From: marek.belisko@open-nandra.com (Marek Belisko)
Date: Mon,  6 Dec 2010 14:25:52 +0100
Subject: [PATCH] omap1: mailbox: Fix compilation warning.
Message-ID: <1291641952-20029-1-git-send-email-marek.belisko@open-nandra.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following compilation warning:
arch/arm/mach-omap1/mailbox.c: In function 'omap1_mbox_probe':
arch/arm/mach-omap1/mailbox.c:148: warning: unused variable 'i'

Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
---
 arch/arm/mach-omap1/mailbox.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 1a85a42..1add133 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -145,7 +145,6 @@ static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *mem;
 	int ret;
-	int i;
 	struct omap_mbox **list;
 
 	list = omap1_mboxes;
-- 
1.7.1
