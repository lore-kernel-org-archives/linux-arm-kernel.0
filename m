From: xiechao.mail@gmail.com (Chao Xie)
Date: Tue, 31 Jul 2012 14:29:08 +0800
Subject: [PATCH 8/8] arm: mmp: change pwm id for pxa910
In-Reply-To: <1343716148-3899-1-git-send-email-xiechao.mail@gmail.com>
References: <1343716148-3899-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1343716148-3899-8-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 arch/arm/mach-mmp/clock-pxa910.c |    8 ++++----
 arch/arm/mach-mmp/pxa910.c       |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-mmp/clock-pxa910.c b/arch/arm/mach-mmp/clock-pxa910.c
index 933ea71..e27a941 100644
--- a/arch/arm/mach-mmp/clock-pxa910.c
+++ b/arch/arm/mach-mmp/clock-pxa910.c
@@ -51,10 +51,10 @@ static struct clk_lookup pxa910_clkregs[] = {
 	INIT_CLKREG(&clk_uart2, "pxa2xx-uart.1", NULL),
 	INIT_CLKREG(&clk_twsi0, "pxa2xx-i2c.0", NULL),
 	INIT_CLKREG(&clk_twsi1, "pxa2xx-i2c.1", NULL),
-	INIT_CLKREG(&clk_pwm1, "pxa910-pwm.0", NULL),
-	INIT_CLKREG(&clk_pwm2, "pxa910-pwm.1", NULL),
-	INIT_CLKREG(&clk_pwm3, "pxa910-pwm.2", NULL),
-	INIT_CLKREG(&clk_pwm4, "pxa910-pwm.3", NULL),
+	INIT_CLKREG(&clk_pwm1, "pxa168-pwm.0", NULL),
+	INIT_CLKREG(&clk_pwm2, "pxa168-pwm.1", NULL),
+	INIT_CLKREG(&clk_pwm3, "pxa168-pwm.2", NULL),
+	INIT_CLKREG(&clk_pwm4, "pxa168-pwm.3", NULL),
 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
 	INIT_CLKREG(&clk_gpio, "pxa-gpio", NULL),
 	INIT_CLKREG(&clk_u2o, NULL, "U2OCLK"),
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 7d84521..314174d 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -129,10 +129,10 @@ PXA910_DEVICE(uart1, "pxa2xx-uart", 0, UART2, 0xd4017000, 0x30, 21, 22);
 PXA910_DEVICE(uart2, "pxa2xx-uart", 1, UART3, 0xd4018000, 0x30, 23, 24);
 PXA910_DEVICE(twsi0, "pxa2xx-i2c", 0, TWSI0, 0xd4011000, 0x28);
 PXA910_DEVICE(twsi1, "pxa2xx-i2c", 1, TWSI1, 0xd4025000, 0x28);
-PXA910_DEVICE(pwm1, "pxa910-pwm", 0, NONE, 0xd401a000, 0x10);
-PXA910_DEVICE(pwm2, "pxa910-pwm", 1, NONE, 0xd401a400, 0x10);
-PXA910_DEVICE(pwm3, "pxa910-pwm", 2, NONE, 0xd401a800, 0x10);
-PXA910_DEVICE(pwm4, "pxa910-pwm", 3, NONE, 0xd401ac00, 0x10);
+PXA910_DEVICE(pwm1, "pxa168-pwm", 0, NONE, 0xd401a000, 0x10);
+PXA910_DEVICE(pwm2, "pxa168-pwm", 1, NONE, 0xd401a400, 0x10);
+PXA910_DEVICE(pwm3, "pxa168-pwm", 2, NONE, 0xd401a800, 0x10);
+PXA910_DEVICE(pwm4, "pxa168-pwm", 3, NONE, 0xd401ac00, 0x10);
 PXA910_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x80, 97, 99);
 
 struct resource pxa910_resource_gpio[] = {
-- 
1.7.0.4
