From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 26 Mar 2012 15:53:57 -0300
Subject: [PATCH] ARM: 3ds_debugboard: Fix smsc911x driver probe
Message-ID: <1332788037-31064-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix smsc911x id field in order to fix smsc911x driver probe error:

smsc911x smsc911x.0: Failed to get supply 'vdd33a': -517
smsc911x smsc911x.0: (unregistered net_device): couldn't get regulators -517
platform smsc911x.0: Driver smsc911x requests probe deferral

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/3ds_debugboard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/3ds_debugboard.c b/arch/arm/plat-mxc/3ds_debugboard.c
index d1e31fa..5cac2c5 100644
--- a/arch/arm/plat-mxc/3ds_debugboard.c
+++ b/arch/arm/plat-mxc/3ds_debugboard.c
@@ -80,7 +80,7 @@ static struct smsc911x_platform_config smsc911x_config = {
 
 static struct platform_device smsc_lan9217_device = {
 	.name = "smsc911x",
-	.id = 0,
+	.id = -1,
 	.dev = {
 		.platform_data = &smsc911x_config,
 	},
-- 
1.7.1
