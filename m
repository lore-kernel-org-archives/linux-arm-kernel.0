From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Thu, 13 May 2010 18:17:39 +0530
Subject: [PATCH v2 2/2] ux500: Add hardware rng support
Message-ID: <1273754859-26365-1-git-send-email-srinidhi.kasagar@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the hardware RNG support to ux500 machine
which uses nomadik RNG driver.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c         |    1 +
 arch/arm/mach-ux500/devices.c              |    5 +++++
 arch/arm/mach-ux500/include/mach/devices.h |    1 +
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index fdcf0d4..602b999 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -124,6 +124,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	&ux500_uart0_device,
 	&ux500_uart1_device,
 	&ux500_uart2_device,
+	&ux500_rng_device,
 	&u8500_ssp0_device,
 };
 
diff --git a/arch/arm/mach-ux500/devices.c b/arch/arm/mach-ux500/devices.c
index 8a26889..65eb79a 100644
--- a/arch/arm/mach-ux500/devices.c
+++ b/arch/arm/mach-ux500/devices.c
@@ -29,6 +29,11 @@ struct amba_device ux500_pl031_device = {
 	.irq = {IRQ_RTC_RTT, NO_IRQ},
 };
 
+struct amba_device ux500_rng_device = {
+	.dev = { .init_name = "rng" },
+	__MEM_4K_RESOURCE(UX500_RNG_BASE),
+};
+
 struct amba_device ux500_uart0_device = {
 	.dev = { .init_name = "uart0" },
 	__MEM_4K_RESOURCE(UX500_UART0_BASE),
diff --git a/arch/arm/mach-ux500/include/mach/devices.h b/arch/arm/mach-ux500/include/mach/devices.h
index 0422af0..72fa6f7 100644
--- a/arch/arm/mach-ux500/include/mach/devices.h
+++ b/arch/arm/mach-ux500/include/mach/devices.h
@@ -18,6 +18,7 @@ extern struct amba_device u8500_ssp0_device;
 extern struct amba_device ux500_uart0_device;
 extern struct amba_device ux500_uart1_device;
 extern struct amba_device ux500_uart2_device;
+extern struct amba_device ux500_rng_device;
 
 extern struct platform_device ux500_i2c1_device;
 extern struct platform_device ux500_i2c2_device;
-- 
1.6.3.3
