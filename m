From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 20 Mar 2018 09:54:15 -0700
Subject: [PATCH v8 18/42] clk: davinci: New driver for TI DA8XX CFGCHIP
 clocks
In-Reply-To: <1521168778-27236-19-git-send-email-david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-19-git-send-email-david@lechnology.com>
Message-ID: <152156485535.183971.1627687499726447092@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting David Lechner (2018-03-15 19:52:34)
> +
> +typedef int (*da8xx_cfgchip_init)(struct device *dev, void __iomem *base);

Should be struct regmap *regmap?

I've squashed this in.

diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
index 858d3786b27b..c971111d2601 100644
--- a/drivers/clk/davinci/da8xx-cfgchip.c
+++ b/drivers/clk/davinci/da8xx-cfgchip.c
@@ -736,7 +736,7 @@ static const struct platform_device_id da8xx_cfgchip_id_table[] = {
 	{ }
 };
 
-typedef int (*da8xx_cfgchip_init)(struct device *dev, void __iomem *base);
+typedef int (*da8xx_cfgchip_init)(struct device *dev, struct regmap *regmap);
 
 static int da8xx_cfgchip_probe(struct platform_device *pdev)
 {
