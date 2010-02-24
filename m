From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 24 Feb 2010 18:50:16 +0100
Subject: [PATCH] ARM: pxa/raumfeld: set GPIO drive bits for LED pins
Message-ID: <1267033816-5331-1-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set GPIO bits to pull the pins connected to LEDs for lower power mode.
We want all LEDs off when devices are in suspend.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/raumfeld.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 06717d7..3184bdc 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -231,6 +231,10 @@ static mfp_cfg_t raumfeld_connector_pin_config[] __initdata = {
 	GPIO26_SSP2_FRM,
 	GPIO27_SSP2_TXD,
 	GPIO29_SSP2_EXTCLK,
+
+	/* LEDs */
+	GPIO35_GPIO | MFP_LPM_PULL_LOW,
+	GPIO36_GPIO | MFP_LPM_DRIVE_HIGH,
 };
 
 static mfp_cfg_t raumfeld_speaker_pin_config[] __initdata = {
@@ -277,6 +281,10 @@ static mfp_cfg_t raumfeld_speaker_pin_config[] __initdata = {
 	GPIO87_SSP1_TXD,
 	GPIO88_SSP1_RXD,
 	GPIO90_SSP1_SYSCLK,
+
+	/* LEDs */
+	GPIO35_GPIO | MFP_LPM_PULL_LOW,
+	GPIO36_GPIO | MFP_LPM_DRIVE_HIGH,
 };
 
 /*
-- 
1.6.6.2
