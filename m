From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Wed, 17 Feb 2010 12:02:56 -0800 (PST)
Subject: [PATCH] mx51_babbage: Fix ckih2 parameter in mx51_clocks_init function
Message-ID: <88241.12409.qm@web51008.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to be applied into Sascha's mxc-master branch.

Fix ckih2 parameter in mx51_clocks_init funtion. CKIH2 pin is left unconnected on Babbage.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_babbage.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index d5ccb5f..ee67a71 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -79,7 +79,7 @@ static void __init mxc_board_init(void)
 
 static void __init mx51_babbage_timer_init(void)
 {
-	mx51_clocks_init(32768, 24000000, 22579200, 24576000);
+	mx51_clocks_init(32768, 24000000, 22579200, 0);
 }
 
 static struct sys_timer mxc_timer = {
-- 
1.6.0.4


      
