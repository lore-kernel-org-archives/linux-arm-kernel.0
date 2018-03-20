From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 20 Mar 2018 09:58:07 -0700
Subject: [PATCH v8 13/42] clk: davinci: Add platform information for TI
 DM355 PSC
In-Reply-To: <1521168778-27236-14-git-send-email-david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-14-git-send-email-david@lechnology.com>
Message-ID: <152156508760.183971.11983086334390852576@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting David Lechner (2018-03-15 19:52:29)
> +static int dm355_psc_init(struct device *dev, void __iomem *base)
> +{
> +       return davinci_psc_register_clocks(base, dm355_psc_info, 42, base);
> +}
> +

Should be dev for that first argument to davinci_psc_register_clocks()?

I squashed this in:

diff --git a/drivers/clk/davinci/psc-dm355.c b/drivers/clk/davinci/psc-dm355.c
index 249a05330457..6995ecea2677 100644
--- a/drivers/clk/davinci/psc-dm355.c
+++ b/drivers/clk/davinci/psc-dm355.c
@@ -70,7 +70,7 @@ static const struct davinci_lpsc_clk_info dm355_psc_info[] = {
 
 static int dm355_psc_init(struct device *dev, void __iomem *base)
 {
-	return davinci_psc_register_clocks(base, dm355_psc_info, 42, base);
+	return davinci_psc_register_clocks(dev, dm355_psc_info, 42, base);
 }
 
 static struct clk_bulk_data dm355_psc_parent_clks[] = {
