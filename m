From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun, 11 Sep 2011 12:28:55 +0300
Subject: [PATCH 7/7] ARM: ep93xx: snappercl15: register audio platform device
In-Reply-To: <cover.1315732452.git.mika.westerberg@iki.fi>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
Message-ID: <e14cdd88908b64b5e8b73588616c2ad890b79313.1315732452.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the ASoC machine driver is now a platform driver we need to register a
matching platform device.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 arch/arm/mach-ep93xx/snappercl15.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index 2e9c614..edd75e3 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -150,6 +150,17 @@ static struct ep93xxfb_mach_info __initdata snappercl15_fb_info = {
 	.bpp			= 16,
 };
 
+static struct platform_device snappercl15_audio_device = {
+	.name		= "snappercl15-audio",
+	.id		= -1,
+};
+
+static void __init snappercl15_register_audio(void)
+{
+	ep93xx_register_i2s();
+	platform_device_register(&snappercl15_audio_device);
+}
+
 static void __init snappercl15_init_machine(void)
 {
 	ep93xx_init_devices();
@@ -157,7 +168,7 @@ static void __init snappercl15_init_machine(void)
 	ep93xx_register_i2c(&snappercl15_i2c_gpio_data, snappercl15_i2c_data,
 			    ARRAY_SIZE(snappercl15_i2c_data));
 	ep93xx_register_fb(&snappercl15_fb_info);
-	ep93xx_register_i2s();
+	snappercl15_register_audio();
 	platform_device_register(&snappercl15_nand_device);
 }
 
-- 
1.7.5.4
