From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 21 Oct 2009 18:05:30 +0100
Subject: [PATCH 2.6.32 1/2] SMDK6410: Configure GPIO pull up for WM835x IRQ
	line
Message-ID: <1256144731-27221-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When used with the WM1190-EV1 board we can use the internal pull up
resistor of the CPU to provide the required pull for the IRQ line.
Without this interrupts from the WM835x don't work in the default
WM1190-EV1 hardwaer configuration.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c6410/mach-smdk6410.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index 72776ff..480d297 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -372,6 +372,9 @@ static int __init smdk6410_wm8350_init(struct wm8350 *wm8350)
 {
 	int i;
 
+	/* Configure the IRQ line */
+	s3c_gpio_setpull(S3C64XX_GPN(12), S3C_GPIO_PULL_UP);
+
 	/* Instantiate the regulators */
 	for (i = 0; i < ARRAY_SIZE(wm1190_regulators); i++)
 		wm8350_register_regulator(wm8350,
-- 
1.6.5
