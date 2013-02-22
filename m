From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Fri, 22 Feb 2013 12:02:44 +0000
Subject: [PATCH] ARM: S3C64XX: Slow down mic detection rate for wm5102
Message-ID: <1361534564-2082-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A slightly slower rate provides more reliable jack detection during
slower insertions.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

This patch does depend on a patch which will be coming through
the extcon tree but this should get merged during this merge
window.

switch: arizona: Support microphone detection rate configuration
commit 2e033db5ddf299de2ae568919d78b0258a5a6423

Thanks,
Charles

 arch/arm/mach-s3c64xx/mach-crag6410-module.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index 755c0bb..4f5ace2 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -210,6 +210,7 @@ static struct arizona_pdata wm5102_reva_pdata = {
 	.gpio_base = CODEC_GPIO_BASE,
 	.irq_active_high = true,
 	.micd_pol_gpio = CODEC_GPIO_BASE + 4,
+	.micd_rate = 6,
 	.gpio_defaults = {
 		[2] = 0x10000, /* AIF3TXLRCLK */
 		[3] = 0x4,     /* OPCLK */
-- 
1.7.2.5
