From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  7 May 2014 19:45:48 +0200
Subject: [PATCH] ARM: at91: sam9260: fix compilation issues
Message-ID: <1399484748-32718-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the hexadecimal values for the triggers to match what is done for the device
tree. This also fixes compilation issues as the defines have been moved
elsewhere.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
I believe that at some point, we may want to reintroduce defines for those
values but we should probably do that in a dt-bindings include and choose better
names as the meaning differ between SoCs.

 arch/arm/mach-at91/at91sam9260_devices.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index fffcd09ac878..a8d0d9cb1bca 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -1307,19 +1307,19 @@ static struct platform_device at91_adc_device = {
 static struct at91_adc_trigger at91_adc_triggers[] = {
 	[0] = {
 		.name = "timer-counter-0",
-		.value = AT91_ADC_TRGSEL_TC0 | AT91_ADC_TRGEN,
+		.value = 0x1,
 	},
 	[1] = {
 		.name = "timer-counter-1",
-		.value = AT91_ADC_TRGSEL_TC1 | AT91_ADC_TRGEN,
+		.value = 0x3,
 	},
 	[2] = {
 		.name = "timer-counter-2",
-		.value = AT91_ADC_TRGSEL_TC2 | AT91_ADC_TRGEN,
+		.value = 0x5,
 	},
 	[3] = {
 		.name = "external",
-		.value = AT91_ADC_TRGSEL_EXTERNAL | AT91_ADC_TRGEN,
+		.value = 0xd,
 		.is_external = true,
 	},
 };
-- 
1.9.1
