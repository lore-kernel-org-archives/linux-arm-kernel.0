From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Thu,  8 Oct 2009 18:12:24 +0200
Subject: [PATCH 1/1] MXC: fix reset for mx31, mx35 and mx27 SoCs
In-Reply-To: <1255018344-17197-1-git-send-email-valentin.longchamp@epfl.ch>
References: <1255018344-17197-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <1255018344-17197-2-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock name for the watchdog devices was not set consistently
with mx21 on these platforms, resulting in the reset not to work.

Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx2/clock_imx27.c |    2 +-
 arch/arm/mach-mx3/clock-imx35.c |    2 +-
 arch/arm/mach-mx3/clock.c       |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx2/clock_imx27.c b/arch/arm/mach-mx2/clock_imx27.c
index 4089951..cf69f5d 100644
--- a/arch/arm/mach-mx2/clock_imx27.c
+++ b/arch/arm/mach-mx2/clock_imx27.c
@@ -665,7 +665,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "sahara2", sahara2_clk)
 	_REGISTER_CLOCK(NULL, "ata", ata_clk)
 	_REGISTER_CLOCK(NULL, "mstick", mstick_clk)
-	_REGISTER_CLOCK(NULL, "wdog", wdog_clk)
+	_REGISTER_CLOCK("imx-wdt.0", NULL, wdog_clk)
 	_REGISTER_CLOCK(NULL, "gpio", gpio_clk)
 	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
 	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index fe5c421..c595260 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -443,7 +443,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxc-ehci.1", "usb", usbotg_clk)
 	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usbotg_clk)
-	_REGISTER_CLOCK("mxc_wdt.0", NULL, wdog_clk)
+	_REGISTER_CLOCK("imx-wdt.0", NULL, wdog_clk)
 	_REGISTER_CLOCK(NULL, "max", max_clk)
 	_REGISTER_CLOCK(NULL, "admux", admux_clk)
 	_REGISTER_CLOCK(NULL, "csi", csi_clk)
diff --git a/arch/arm/mach-mx3/clock.c b/arch/arm/mach-mx3/clock.c
index 06bd618..b2a3bcf 100644
--- a/arch/arm/mach-mx3/clock.c
+++ b/arch/arm/mach-mx3/clock.c
@@ -530,7 +530,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("spi_imx.2", NULL, cspi3_clk)
 	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
 	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
-	_REGISTER_CLOCK(NULL, "wdog", wdog_clk)
+	_REGISTER_CLOCK("imx-wdt.0", NULL, wdog_clk)
 	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
 	_REGISTER_CLOCK(NULL, "epit", epit1_clk)
 	_REGISTER_CLOCK(NULL, "epit", epit2_clk)
-- 
1.6.0.4
