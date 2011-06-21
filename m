From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Jun 2011 00:24:49 +0100
Subject: [PATCH] ARM: Fix WM8915 IRQ polarity on Cragganmore
Message-ID: <1308698689-17090-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The chip IRQ output is genuinely an IRQ output rather than /IRQ output by
default - this had been working due to an interface issue with the IRQ
controller.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index cf4505c..9f28389 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -649,7 +649,7 @@ static struct wm8915_pdata wm8915_pdata __initdata = {
 	.inl_mode = WM8915_DIFFERRENTIAL_1,
 	.inr_mode = WM8915_DIFFERRENTIAL_1,
 
-	.irq_flags = IRQF_TRIGGER_FALLING,
+	.irq_flags = IRQF_TRIGGER_RISING,
 
 	.gpio_default = {
 		0x8001, /* GPIO1 == ADCLRCLK1 */
-- 
1.7.5.4
