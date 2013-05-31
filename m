From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:18:46 +0200
Subject: [PATCH 11/39] ARM: u300: add RTC to device tree
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-12-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds the COH 901 331 RTC to the U300 device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-u300.dts | 7 +++++++
 arch/arm/mach-u300/core.c      | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index f0eb5f4..711a2d9 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -56,6 +56,13 @@
 		interrupts = <3>;
 	};
 
+	rtc: rtc at c0017000 {
+		compatible = "stericsson,coh901331";
+		reg = <0xc0017000 0x1000>;
+		interrupt-parent = <&vicb>;
+		interrupts = <10>;
+	};
+
 	i2c0: i2c at c0004000 {
 		compatible = "st,ddci2c";
 		reg = <0xc0004000 0x1000>;
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 190e788..637034b 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -712,6 +712,8 @@ static struct of_dev_auxdata u300_auxdata_lookup[] __initdata = {
 		"u300-gpio", &u300_gpio_plat),
 	OF_DEV_AUXDATA("stericsson,coh901327", U300_WDOG_BASE,
 		"coh901327_wdog", NULL),
+	OF_DEV_AUXDATA("stericsson,coh901331", U300_RTC_BASE,
+		"rtc-coh901331", NULL),
 	OF_DEV_AUXDATA("arm,primecell", U300_UART0_BASE,
 		"uart0", &uart0_plat_data),
 	OF_DEV_AUXDATA("arm,primecell", U300_UART1_BASE,
-- 
1.7.11.3
