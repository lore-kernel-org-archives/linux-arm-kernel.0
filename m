From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun, 11 Sep 2011 12:28:53 +0300
Subject: [PATCH 5/7] ARM: ep93xx: simone: register audio platform device
In-Reply-To: <cover.1315732452.git.mika.westerberg@iki.fi>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
Message-ID: <a5aee908e7772299753f4faf95c38ca903534084.1315732452.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the ASoC machine driver is now a platform driver we need to register
a matching platform device.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 arch/arm/mach-ep93xx/simone.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 8392e95..1445ce5 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -53,6 +53,17 @@ static struct i2c_board_info __initdata simone_i2c_board_info[] = {
 	},
 };
 
+static struct platform_device simone_audio_device = {
+	.name		= "simone-audio",
+	.id		= -1,
+};
+
+static void __init simone_register_audio(void)
+{
+	ep93xx_register_ac97();
+	platform_device_register(&simone_audio_device);
+}
+
 static void __init simone_init_machine(void)
 {
 	ep93xx_init_devices();
@@ -61,7 +72,7 @@ static void __init simone_init_machine(void)
 	ep93xx_register_fb(&simone_fb_info);
 	ep93xx_register_i2c(&simone_i2c_gpio_data, simone_i2c_board_info,
 			    ARRAY_SIZE(simone_i2c_board_info));
-	ep93xx_register_ac97();
+	simone_register_audio();
 }
 
 MACHINE_START(SIM_ONE, "Simplemachines Sim.One Board")
-- 
1.7.5.4
