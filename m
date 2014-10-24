From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 24 Oct 2014 21:50:04 +0400
Subject: [PATCH V3 1/2] ARM: pxa: spitz: register spitz-audio device
Message-ID: <1414173005-20967-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register spitz-audio device to be used by ASoC driver to bind ASoC
platform driver. Currently old 'soc-audio' approach is used, which needs
to be replaced with proper device.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/spitz.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 840c3a4..962a7f3 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -924,6 +924,14 @@ static inline void spitz_i2c_init(void) {}
 #endif
 
 /******************************************************************************
+ * Audio devices
+ ******************************************************************************/
+static inline void spitz_audio_init(void)
+{
+	platform_device_register_simple("spitz-audio", -1, NULL, 0);
+}
+
+/******************************************************************************
  * Machine init
  ******************************************************************************/
 static void spitz_poweroff(void)
@@ -970,6 +978,7 @@ static void __init spitz_init(void)
 	spitz_nor_init();
 	spitz_nand_init();
 	spitz_i2c_init();
+	spitz_audio_init();
 }
 
 static void __init spitz_fixup(struct tag *tags, char **cmdline)
-- 
2.1.1
