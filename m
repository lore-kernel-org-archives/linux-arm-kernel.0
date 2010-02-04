From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu,  4 Feb 2010 09:45:55 +0100
Subject: [PATCH 2/2] Add RTC PL031 derivative platform config for ux500
Message-ID: <1265273155-22687-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This configures the PL031 RTC resources for ux500.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index ae22184..0cc61ae 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -108,11 +108,24 @@ static struct amba_device pl022_device = {
 	.periphid = SSP_PER_ID,
 };
 
+static struct amba_device pl031_device = {
+	.dev = {
+		.init_name = "pl031",
+	},
+	.res = {
+		.start = U8500_RTC_BASE,
+		.end = U8500_RTC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_RTC_RTT, NO_IRQ},
+};
+
 static struct amba_device *amba_devs[] __initdata = {
 	&uart0_device,
 	&uart1_device,
 	&uart2_device,
 	&pl022_device,
+	&pl031_device,
 };
 
 static void __init u8500_timer_init(void)
-- 
1.6.3.3
