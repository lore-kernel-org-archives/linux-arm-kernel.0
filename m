From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  9 Oct 2017 22:53:39 +0200
Subject: [PATCH v2 3/3] pinctrl: sunxi: Enforce the strict mode by default
In-Reply-To: <cover.3e8ef5cb08d0164375d7644df0548e5f39b0fe66.1507582414.git-series.maxime.ripard@free-electrons.com>
References: <cover.3e8ef5cb08d0164375d7644df0548e5f39b0fe66.1507582414.git-series.maxime.ripard@free-electrons.com>
Message-ID: <b88debdc2ed1dd2488fad802be1a9e6f31bf67a4.1507582414.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The strict mode should always have been enabled on our driver, and leaving
it unchecked just makes it harder to find a migration path as time passes.

Let's enable it by default now so that hopefully the new SoCs should be
safe.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 3bbb34435e0f..4b6cb25bc796 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -696,6 +696,7 @@ static const struct pinmux_ops sunxi_pmx_ops = {
 	.get_function_groups	= sunxi_pmx_get_func_groups,
 	.set_mux		= sunxi_pmx_set_mux,
 	.gpio_set_direction	= sunxi_pmx_gpio_set_direction,
+	.strict			= true,
 };
 
 static int sunxi_pinctrl_gpio_direction_input(struct gpio_chip *chip,
-- 
git-series 0.9.1
