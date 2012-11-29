From: dromede@gmail.com (dromede at gmail.com)
Date: Fri, 30 Nov 2012 00:41:21 +0100
Subject: [PATCH] [ARM] pxa/spitz: Disable usb port 1 and 3
Message-ID: <1354232481-32168-1-git-send-email-dromede@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marko Katic <dromede.gmail.com>

Spitz devices only have a single mini usb a/b plug
connected to usb port 2.
This patch disables ports 1 and 3 since they are not used.

Signed-off-by: Marko Katic <dromede@gmail.com>
---
 arch/arm/mach-pxa/spitz.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 0f92264..4443540 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -651,7 +651,7 @@ static struct pxaohci_platform_data spitz_ohci_platform_data = {
 	.port_mode	= PMM_NPS_MODE,
 	.init		= spitz_ohci_init,
 	.exit		= spitz_ohci_exit,
-	.flags		= ENABLE_PORT_ALL | NO_OC_PROTECTION,
+	.flags		= ENABLE_PORT2 | NO_OC_PROTECTION,
 	.power_budget	= 150,
 };
 
-- 
1.7.10.4
