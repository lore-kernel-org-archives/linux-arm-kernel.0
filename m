From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 22:54:08 +0200
Subject: [PATCH 3/3] pinctrl: sunxi: Enforce the strict mode by default
In-Reply-To: <cover.7a61d0bb31530def29efd8b4286d8c0afdaab347.1507236823.git-series.maxime.ripard@free-electrons.com>
References: <cover.7a61d0bb31530def29efd8b4286d8c0afdaab347.1507236823.git-series.maxime.ripard@free-electrons.com>
Message-ID: <817a66704d6c8f3caa034a526db11e25a9152a65.1507236823.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The strict mode should always have been enabled on our driver, and leaving
it unchecked just makes it harder to find a migration path as time passes.

Let's enable it by default now so that hopefully the new SoCs should be
safe.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 1753a5b1573f..2313c3b8931a 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -696,6 +696,7 @@ static struct pinmux_ops sunxi_pmx_ops = {
 	.get_function_groups	= sunxi_pmx_get_func_groups,
 	.set_mux		= sunxi_pmx_set_mux,
 	.gpio_set_direction	= sunxi_pmx_gpio_set_direction,
+	.strict			= true,
 };
 
 static int sunxi_pinctrl_gpio_direction_input(struct gpio_chip *chip,
-- 
git-series 0.9.1
