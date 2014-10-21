From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 22 Oct 2014 01:15:32 +0400
Subject: [PATCH V2 1/2] ARM: pxa: spitz: register spitz-audio device
Message-ID: <1413926133-3566-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register spitz-audio device to be used by ASoC driver.

[V2: Removed ifdefs around spitz_audio_init].

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/spitz.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 840c3a4..af1dea3 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -924,6 +924,19 @@ static inline void spitz_i2c_init(void) {}
 #endif
 
 /******************************************************************************
+ * Audio devices
+ ******************************************************************************/
+static struct platform_device spitz_audio_device = {
+	.name	= "spitz-audio",
+	.id	= -1,
+};
+
+static inline void spitz_audio_init(void)
+{
+	platform_device_register(&spitz_audio_device);
+}
+
+/******************************************************************************
  * Machine init
  ******************************************************************************/
 static void spitz_poweroff(void)
@@ -970,6 +983,7 @@ static void __init spitz_init(void)
 	spitz_nor_init();
 	spitz_nand_init();
 	spitz_i2c_init();
+	spitz_audio_init();
 }
 
 static void __init spitz_fixup(struct tag *tags, char **cmdline)
-- 
2.1.1
