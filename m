From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 22 Apr 2013 11:59:39 +0200
Subject: [PATCH 19/23] ARM: u300: add the COH 901 318 DMAC to device tree
Message-ID: <1366624779-6820-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds the COH 901 318 DMA controller to the U300
device tree. All devices now converted to device tree
so far will start to find their DMA channels.

Note that the U300 is not yet using the device tree
to obtain DMA channels, but this is a first step.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-u300.dts | 7 +++++++
 arch/arm/mach-u300/core.c      | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index ee747fe..cdffeb9 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -68,6 +68,13 @@
 		interrupts = <10>;
 	};
 
+	dmac: dmac at c00020000 {
+		compatible = "stericsson,coh901318";
+		reg = <0xc0020000 0x1000>;
+		interrupt-parent = <&vica>;
+		interrupts = <2>;
+	};
+
 	i2c0: i2c at c0004000 {
 		compatible = "st,ddci2c";
 		reg = <0xc0004000 0x1000>;
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 20d6c46..98d4dbe 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -713,6 +713,8 @@ static struct of_dev_auxdata u300_auxdata_lookup[] __initdata = {
 		"coh901327_wdog", NULL),
 	OF_DEV_AUXDATA("stericsson,coh901331", U300_RTC_BASE,
 		"rtc-coh901331", NULL),
+	OF_DEV_AUXDATA("stericsson,coh901318", U300_DMAC_BASE,
+		"coh901318", NULL),
 	OF_DEV_AUXDATA("arm,primecell", U300_UART0_BASE,
 		"uart0", &uart0_plat_data),
 	OF_DEV_AUXDATA("arm,primecell", U300_UART1_BASE,
-- 
1.7.11.3
