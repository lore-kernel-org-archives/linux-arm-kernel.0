From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 14 Feb 2012 21:48:33 -0200
Subject: [PATCH] ARM: mach-pcm038: Fix field name of regulator_consumer_supply
 struct
Message-ID: <1329263313-5014-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building imx_v4_v5_defconfig generates the following error:

arch/arm/mach-imx/mach-pcm038.c:236: error: unknown field 'dev' specified in initializer
make[1]: *** [arch/arm/mach-imx/mach-pcm038.o] Error 1

Fix it by providing the correct "dev_name" field name.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-pcm038.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 16f126d..2f3debe 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -233,7 +233,7 @@ static struct regulator_init_data sdhc1_data = {
 
 static struct regulator_consumer_supply cam_consumers[] = {
 	{
-		.dev	= NULL,
+		.dev_name = NULL,
 		.supply	= "imx_cam_vcc",
 	},
 };
-- 
1.7.1
