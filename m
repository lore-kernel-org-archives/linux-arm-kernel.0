From: mturquette@ti.com (Mike Turquette)
Date: Tue, 12 Jun 2012 16:06:30 -0700
Subject: [PATCH 2/3] clk: add ICST307 driver
In-Reply-To: <1339429196-32584-1-git-send-email-linus.walleij@linaro.org>
References: <1339429196-32584-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20120612230630.GK19410@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120611-17:39, Linus Walleij wrote:
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index b9a5158..a7a7cf8 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-fixed-rate.o clk-gate.o \
>  # SoCs specific
>  obj-$(CONFIG_ARCH_MXS)		+= mxs/
>  obj-$(CONFIG_PLAT_SPEAR)	+= spear/
> +obj-$(CONFIG_CLK_ICST)		+= clk-icst.o

Is there a better place to put this than the top-level directory?

> +struct clk * __init icst_clk_init(struct device *dev, const struct clk_icst_desc *desc)

Nitpick: icst_clk_init should be renamed icst_clk_register to more
closely resemble other clock registration functions which allocate
memory dynamically.

So far the "_init" suffix has been used by functions which operate on
statically initialized data.

Regards,
Mike
