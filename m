From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Wed, 3 Jun 2015 15:09:38 -0400
Subject: [PATCH] drivers/clk: convert sunxi/clk-mod0.c to use
 builtin_platform_driver
In-Reply-To: <1431287385-1526-1-git-send-email-paul.gortmaker@windriver.com>
References: <1431287385-1526-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1433358578-9579-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver builds based on obj-y and hence will not ever be
modular.  Change it to use the non-modular registration so that it
won't suffer a compile fail once a header move places the modular
registration within the module.h file.

Cc: "Emilio L?pez" <emilio@elopez.com.ar>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-clk at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[appending this to the builtin_platform_driver series of commits; see
 https://lkml.kernel.org/r/1431287385-1526-1-git-send-email-paul.gortmaker at windriver.com
 for original series posting.  The final header move can be found at:
 https://lkml.kernel.org/r/1433276168-21550-1-git-send-email-paul.gortmaker at windriver.com ]

 drivers/clk/sunxi/clk-mod0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
index ec8f5a1fca09..9d028aec58e5 100644
--- a/drivers/clk/sunxi/clk-mod0.c
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -128,7 +128,7 @@ static struct platform_driver sun4i_a10_mod0_clk_driver = {
 	},
 	.probe = sun4i_a10_mod0_clk_probe,
 };
-module_platform_driver(sun4i_a10_mod0_clk_driver);
+builtin_platform_driver(sun4i_a10_mod0_clk_driver);
 
 static const struct factors_data sun9i_a80_mod0_data __initconst = {
 	.enable = 31,
-- 
2.2.1
