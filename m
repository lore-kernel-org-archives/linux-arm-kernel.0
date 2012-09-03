From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 3 Sep 2012 21:24:01 +0000
Subject: [PATCH 06/11] clk: Common clocks implementation for Versatile
 Express
In-Reply-To: <1346689531-7212-7-git-send-email-pawel.moll@arm.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
 <1346689531-7212-7-git-send-email-pawel.moll@arm.com>
Message-ID: <201209032124.02224.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 September 2012, Pawel Moll wrote:
> +void __init vexpress_clk_init(void __iomem *sp810_base)
> +{
> +       struct clk *clk;
> +       int i;
> +
> +       clk = clk_register_fixed_rate(NULL, "dummy_apb_pclk", NULL,
> +                       CLK_IS_ROOT, 0);
> +       WARN_ON(clk_register_clkdev(clk, "apb_pclk", NULL));
> +

Isn't it time to just remove the non-DT parts of vexpress? That would
also simplify this driver.

	Arnd
