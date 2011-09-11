From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun, 11 Sep 2011 12:28:54 +0300
Subject: [PATCH 6/7] ARM: ep93xx: edb93xx: register audio platform device
In-Reply-To: <cover.1315732452.git.mika.westerberg@iki.fi>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
Message-ID: <1e18f75e7557c06df040356b9c4e9c0fc1e196d5.1315732452.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the ASoC machine driver is now a platform driver we need to register a
matching platform device.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
Cc: Alexander Sverdlin <subaparts@yandex.ru>
---
 arch/arm/mach-ep93xx/edb93xx.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 9969bb1..8dc51e4 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -159,6 +159,11 @@ static void __init edb93xx_register_spi(void)
 /*************************************************************************
  * EDB93xx I2S
  *************************************************************************/
+static struct platform_device edb93xx_audio_device = {
+	.name		= "edb93xx-audio",
+	.id		= -1,
+};
+
 static int __init edb93xx_has_audio(void)
 {
 	return (machine_is_edb9301() || machine_is_edb9302() ||
@@ -170,6 +175,7 @@ static void __init edb93xx_register_i2s(void)
 {
 	if (edb93xx_has_audio()) {
 		ep93xx_register_i2s();
+		platform_device_register(&edb93xx_audio_device);
 	}
 }
 
-- 
1.7.5.4
