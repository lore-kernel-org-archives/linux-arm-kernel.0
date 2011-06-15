From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 15 Jun 2011 10:43:10 +0200
Subject: [PATCH] mach-ixp4xx: fix build error
Message-ID: <1308127390-30563-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The introduction of clocksource_mmio_init() broke ixp4xx due to
a surplus ampersand - IXP4XX_OSTS is already a pointe to I/O
space.

Cc: Deepak Saxena <deepak.saxena@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ixp4xx/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 74ed81a..5ec2918 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -425,7 +425,7 @@ static void __init ixp4xx_clocksource_init(void)
 {
 	init_sched_clock(&cd, ixp4xx_update_sched_clock, 32, ixp4xx_timer_freq);
 
-	clocksource_mmio_init(&IXP4XX_OSTS, "OSTS", ixp4xx_timer_freq, 200, 32,
+	clocksource_mmio_init(IXP4XX_OSTS, "OSTS", ixp4xx_timer_freq, 200, 32,
 			clocksource_mmio_readl_up);
 }
 
-- 
1.7.3.2
