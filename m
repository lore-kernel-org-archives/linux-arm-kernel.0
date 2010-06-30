From: siccegge@cs.fau.de (Christoph Egger)
Date: Wed, 30 Jun 2010 18:03:26 +0200
Subject: [PATCH 30/33] Removing dead S3C_DEV_ADC
In-Reply-To: <cover.1277911345.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
Message-ID: <7baaebb4983ce9482e3f83ca42240b864157cb79.1277911346.git.siccegge@cs.fau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S3C_DEV_ADC doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/arm/mach-s5pv210/cpu.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 411a4a9..c5d53ab 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -76,10 +76,6 @@ static void s5pv210_idle(void)
 
 void __init s5pv210_map_io(void)
 {
-#ifdef CONFIG_S3C_DEV_ADC
-	s3c_device_adc.name	= "s3c64xx-adc";
-#endif
-
 	iotable_init(s5pv210_iodesc, ARRAY_SIZE(s5pv210_iodesc));
 
 	/* initialise device information early */
-- 
1.7.0.4
