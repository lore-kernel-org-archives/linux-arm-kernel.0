From: axel.lin@gmail.com (Axel Lin)
Date: Fri, 17 Feb 2012 11:25:21 +0800
Subject: [PATCH 2/2] ARM: imx/pcm038: Don't specify regulator consumers by
 struct device
In-Reply-To: <1329449029.17110.1.camel@phoenix>
References: <1329449029.17110.1.camel@phoenix>
Message-ID: <1329449121.17110.2.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dev field is remove from struct regulator_consumer_supply since commit
737f36 "regulator: Remove support for supplies specified by struct device".

This fixes below build error:
  CC      arch/arm/mach-imx/mach-pcm038.o
arch/arm/mach-imx/mach-pcm038.c:236: error: unknown field 'dev' specified in initializer
make[1]: *** [arch/arm/mach-imx/mach-pcm038.o] Error 1
make: *** [arch/arm/mach-imx] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
This patch is against linux-next 20120217.

 arch/arm/mach-imx/mach-pcm038.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 16f126d..bfcc1ea 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -233,7 +233,6 @@ static struct regulator_init_data sdhc1_data = {
 
 static struct regulator_consumer_supply cam_consumers[] = {
 	{
-		.dev	= NULL,
 		.supply	= "imx_cam_vcc",
 	},
 };
-- 
1.7.5.4
