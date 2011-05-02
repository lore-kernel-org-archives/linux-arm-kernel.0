From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Mon,  2 May 2011 11:29:58 +0530
Subject: [PATCH 1/3] ARM: pxa168: Add support for UART3
In-Reply-To: <1304316000-869-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <1304316000-869-1-git-send-email-tanmay.upadhyay@einfochips.com>
Message-ID: <1304316000-869-2-git-send-email-tanmay.upadhyay@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PXA168 has 3 onchip UARTs. Added support for the third one

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
---
 arch/arm/mach-mmp/include/mach/pxa168.h |    2 ++
 arch/arm/mach-mmp/pxa168.c              |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index a52b3d2..705e963 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -17,6 +17,7 @@ extern void pxa168_clear_keypad_wakeup(void);
 
 extern struct pxa_device_desc pxa168_device_uart1;
 extern struct pxa_device_desc pxa168_device_uart2;
+extern struct pxa_device_desc pxa168_device_uart3;
 extern struct pxa_device_desc pxa168_device_twsi0;
 extern struct pxa_device_desc pxa168_device_twsi1;
 extern struct pxa_device_desc pxa168_device_pwm1;
@@ -39,6 +40,7 @@ static inline int pxa168_add_uart(int id)
 	switch (id) {
 	case 1: d = &pxa168_device_uart1; break;
 	case 2: d = &pxa168_device_uart2; break;
+	case 3: d = &pxa168_device_uart3; break;
 	}
 
 	if (d == NULL)
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 72b4e76..dcb203b 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -66,6 +66,7 @@ void __init pxa168_init_irq(void)
 /* APB peripheral clocks */
 static APBC_CLK(uart1, PXA168_UART1, 1, 14745600);
 static APBC_CLK(uart2, PXA168_UART2, 1, 14745600);
+static APBC_CLK(uart3, PXA168_UART3, 1, 14745600);
 static APBC_CLK(twsi0, PXA168_TWSI0, 1, 33000000);
 static APBC_CLK(twsi1, PXA168_TWSI1, 1, 33000000);
 static APBC_CLK(pwm1, PXA168_PWM1, 1, 13000000);
@@ -86,6 +87,7 @@ static APMU_CLK(lcd, LCD, 0x7f, 312000000);
 static struct clk_lookup pxa168_clkregs[] = {
 	INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
 	INIT_CLKREG(&clk_uart2, "pxa2xx-uart.1", NULL),
+	INIT_CLKREG(&clk_uart3, "pxa2xx-uart.2", NULL),
 	INIT_CLKREG(&clk_twsi0, "pxa2xx-i2c.0", NULL),
 	INIT_CLKREG(&clk_twsi1, "pxa2xx-i2c.1", NULL),
 	INIT_CLKREG(&clk_pwm1, "pxa168-pwm.0", NULL),
@@ -149,6 +151,7 @@ void pxa168_clear_keypad_wakeup(void)
 /* on-chip devices */
 PXA168_DEVICE(uart1, "pxa2xx-uart", 0, UART1, 0xd4017000, 0x30, 21, 22);
 PXA168_DEVICE(uart2, "pxa2xx-uart", 1, UART2, 0xd4018000, 0x30, 23, 24);
+PXA168_DEVICE(uart3, "pxa2xx-uart", 2, UART3, 0xd4026000, 0x30, 23, 24);
 PXA168_DEVICE(twsi0, "pxa2xx-i2c", 0, TWSI0, 0xd4011000, 0x28);
 PXA168_DEVICE(twsi1, "pxa2xx-i2c", 1, TWSI1, 0xd4025000, 0x28);
 PXA168_DEVICE(pwm1, "pxa168-pwm", 0, NONE, 0xd401a000, 0x10);
-- 
1.7.0.4
