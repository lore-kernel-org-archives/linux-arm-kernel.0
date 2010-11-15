From: joe@perches.com (Joe Perches)
Date: Sun, 14 Nov 2010 19:04:20 -0800
Subject: [PATCH 01/44] arch/arm: Remove unnecessary semicolons
In-Reply-To: <cover.1289789604.git.joe@perches.com>
References: <cover.1289789604.git.joe@perches.com>
Message-ID: <b6d517c8da3ca0d50c836736e76059c89d692b6e.1289789604.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/mach-at91/at91cap9_devices.c    |    2 +-
 arch/arm/mach-at91/at91sam9g45_devices.c |    2 +-
 arch/arm/mach-at91/at91sam9rl_devices.c  |    2 +-
 arch/arm/mach-nuc93x/time.c              |    2 +-
 arch/arm/mach-tegra/tegra2_clocks.c      |    2 +-
 arch/arm/mach-w90x900/cpu.c              |    2 +-
 arch/arm/plat-mxc/irq.c                  |    2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index d1f775e..308ce7a 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -171,7 +171,7 @@ void __init at91_add_device_usba(struct usba_platform_data *data)
 	 */
 	usba_udc_data.pdata.vbus_pin = -EINVAL;
 	usba_udc_data.pdata.num_ep = ARRAY_SIZE(usba_udc_ep);
-	memcpy(usba_udc_data.ep, usba_udc_ep, sizeof(usba_udc_ep));;
+	memcpy(usba_udc_data.ep, usba_udc_ep, sizeof(usba_udc_ep));
 
 	if (data && data->vbus_pin > 0) {
 		at91_set_gpio_input(data->vbus_pin, 0);
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 1e8f275..5e9f8a4 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -256,7 +256,7 @@ void __init at91_add_device_usba(struct usba_platform_data *data)
 {
 	usba_udc_data.pdata.vbus_pin = -EINVAL;
 	usba_udc_data.pdata.num_ep = ARRAY_SIZE(usba_udc_ep);
-	memcpy(usba_udc_data.ep, usba_udc_ep, sizeof(usba_udc_ep));;
+	memcpy(usba_udc_data.ep, usba_udc_ep, sizeof(usba_udc_ep));
 
 	if (data && data->vbus_pin > 0) {
 		at91_set_gpio_input(data->vbus_pin, 0);
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 53aaa94..c49262b 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -145,7 +145,7 @@ void __init at91_add_device_usba(struct usba_platform_data *data)
 	 */
 	usba_udc_data.pdata.vbus_pin = -EINVAL;
 	usba_udc_data.pdata.num_ep = ARRAY_SIZE(usba_udc_ep);
-	memcpy(usba_udc_data.ep, usba_udc_ep, sizeof(usba_udc_ep));;
+	memcpy(usba_udc_data.ep, usba_udc_ep, sizeof(usba_udc_ep));
 
 	if (data && data->vbus_pin > 0) {
 		at91_set_gpio_input(data->vbus_pin, 0);
diff --git a/arch/arm/mach-nuc93x/time.c b/arch/arm/mach-nuc93x/time.c
index 2f90f9d..f9807c0 100644
--- a/arch/arm/mach-nuc93x/time.c
+++ b/arch/arm/mach-nuc93x/time.c
@@ -82,7 +82,7 @@ static void nuc93x_timer_setup(void)
 	timer0_load = (rate / TICKS_PER_SEC);
 	__raw_writel(timer0_load, REG_TICR0);
 
-	val |= (PERIOD | COUNTEN | INTEN | PRESCALE);;
+	val |= (PERIOD | COUNTEN | INTEN | PRESCALE);
 	__raw_writel(val, REG_TCSR0);
 
 }
diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
index ae3b308..7f9d2252 100644
--- a/arch/arm/mach-tegra/tegra2_clocks.c
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -293,7 +293,7 @@ static int tegra2_super_clk_set_parent(struct clk *c, struct clk *p)
 	const struct clk_mux_sel *sel;
 	int shift;
 
-	val = clk_readl(c->reg + SUPER_CLK_MUX);;
+	val = clk_readl(c->reg + SUPER_CLK_MUX);
 	BUG_ON(((val & SUPER_STATE_MASK) != SUPER_STATE_RUN) &&
 		((val & SUPER_STATE_MASK) != SUPER_STATE_IDLE));
 	shift = ((val & SUPER_STATE_MASK) == SUPER_STATE_IDLE) ?
diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
index 83c5632..0a235e5 100644
--- a/arch/arm/mach-w90x900/cpu.c
+++ b/arch/arm/mach-w90x900/cpu.c
@@ -60,7 +60,7 @@ static DEFINE_CLK(emc, 7);
 static DEFINE_SUBCLK(rmii, 2);
 static DEFINE_CLK(usbd, 8);
 static DEFINE_CLK(usbh, 9);
-static DEFINE_CLK(g2d, 10);;
+static DEFINE_CLK(g2d, 10);
 static DEFINE_CLK(pwm, 18);
 static DEFINE_CLK(ps2, 24);
 static DEFINE_CLK(kpi, 25);
diff --git a/arch/arm/plat-mxc/irq.c b/arch/arm/plat-mxc/irq.c
index 7331f2a..d7809d0 100644
--- a/arch/arm/plat-mxc/irq.c
+++ b/arch/arm/plat-mxc/irq.c
@@ -53,7 +53,7 @@ int imx_irq_set_priority(unsigned char irq, unsigned char prio)
 	unsigned int mask = 0x0F << irq % 8 * 4;
 
 	if (irq >= MXC_INTERNAL_IRQS)
-		return -EINVAL;;
+		return -EINVAL;
 
 	temp = __raw_readl(avic_base + AVIC_NIPRIORITY(irq / 8));
 	temp &= ~mask;
-- 
1.7.3.1.g432b3.dirty
