From: zonque@gmail.com (Daniel Mack)
Date: Tue, 24 May 2011 14:13:43 +0200
Subject: [PATCH 2/2] ARM: pxa: raumfeld: fix device name for codec ak4104
In-Reply-To: <1306239223-8293-1-git-send-email-zonque@gmail.com>
References: <1306239223-8293-1-git-send-email-zonque@gmail.com>
Message-ID: <1306239223-8293-2-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit f0fba2ad (ASoC: multi-component - ASoC Multi-Component
Support), the name of the ak4104 codec driver was changed without
amending the platform code which uses it as well.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-pxa/raumfeld.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index b18b486..909f5df 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -661,10 +661,10 @@ static struct lis3lv02d_platform_data lis3_pdata = {
 
 #define SPI_AK4104	\
 {			\
-	.modalias	= "ak4104",	\
-	.max_speed_hz	= 10000,	\
-	.bus_num	= 0,		\
-	.chip_select	= 0,		\
+	.modalias	= "ak4104-codec",	\
+	.max_speed_hz	= 10000,		\
+	.bus_num	= 0,			\
+	.chip_select	= 0,			\
 	.controller_data = (void *) GPIO_SPDIF_CS,	\
 }
 
-- 
1.7.5.1
