From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 28 May 2014 12:27:29 +0200
Subject: [PATCH 3/5] pinctrl: sunxi: Declare the number of interrupt banks in
 the descriptor
In-Reply-To: <1401272851-15873-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1401272851-15873-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1401272851-15873-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare in the description structure associated to the compatible the number of
interrupt banks the device has. For now, we're not doing anything with it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c   | 1 +
 drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c  | 1 +
 drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c   | 1 +
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c | 1 +
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c   | 1 +
 drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c   | 1 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.h       | 1 +
 7 files changed, 7 insertions(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
index fa1ff7c7e357..86b608bedca6 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
@@ -1010,6 +1010,7 @@ static const struct sunxi_desc_pin sun4i_a10_pins[] = {
 static const struct sunxi_pinctrl_desc sun4i_a10_pinctrl_data = {
 	.pins = sun4i_a10_pins,
 	.npins = ARRAY_SIZE(sun4i_a10_pins),
+	.irq_banks = 1,
 };
 
 static int sun4i_a10_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c b/drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c
index 164d743f526c..2fa7430cabaf 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c
@@ -661,6 +661,7 @@ static const struct sunxi_desc_pin sun5i_a10s_pins[] = {
 static const struct sunxi_pinctrl_desc sun5i_a10s_pinctrl_data = {
 	.pins = sun5i_a10s_pins,
 	.npins = ARRAY_SIZE(sun5i_a10s_pins),
+	.irq_banks = 1,
 };
 
 static int sun5i_a10s_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c b/drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c
index 1188a2b7b988..29c734a60b51 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c
@@ -382,6 +382,7 @@ static const struct sunxi_desc_pin sun5i_a13_pins[] = {
 static const struct sunxi_pinctrl_desc sun5i_a13_pinctrl_data = {
 	.pins = sun5i_a13_pins,
 	.npins = ARRAY_SIZE(sun5i_a13_pins),
+	.irq_banks = 1,
 };
 
 static int sun5i_a13_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
index 8fcba48e0a42..9a2517b65113 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
@@ -93,6 +93,7 @@ static const struct sunxi_pinctrl_desc sun6i_a31_r_pinctrl_data = {
 	.pins = sun6i_a31_r_pins,
 	.npins = ARRAY_SIZE(sun6i_a31_r_pins),
 	.pin_base = PL_BASE,
+	.irq_banks = 2,
 };
 
 static int sun6i_a31_r_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
index 8dea5856458b..7adc4888eb27 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
@@ -836,6 +836,7 @@ static const struct sunxi_desc_pin sun6i_a31_pins[] = {
 static const struct sunxi_pinctrl_desc sun6i_a31_pinctrl_data = {
 	.pins = sun6i_a31_pins,
 	.npins = ARRAY_SIZE(sun6i_a31_pins),
+	.irq_banks = 4,
 };
 
 static int sun6i_a31_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c b/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
index d8577ce5f1a4..dac99e02bfdb 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
@@ -1036,6 +1036,7 @@ static const struct sunxi_desc_pin sun7i_a20_pins[] = {
 static const struct sunxi_pinctrl_desc sun7i_a20_pinctrl_data = {
 	.pins = sun7i_a20_pins,
 	.npins = ARRAY_SIZE(sun7i_a20_pins),
+	.irq_banks = 1,
 };
 
 static int sun7i_a20_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index cb87e15b1b3c..7ddcce0f3c27 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -90,6 +90,7 @@ struct sunxi_pinctrl_desc {
 	const struct sunxi_desc_pin	*pins;
 	int				npins;
 	unsigned			pin_base;
+	unsigned			irq_banks;
 };
 
 struct sunxi_pinctrl_function {
-- 
1.9.3
