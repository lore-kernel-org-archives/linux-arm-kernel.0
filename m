From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Nov 2016 10:22:22 +0100
Subject: [PATCH v3 3/3] pinctrl: sunxi: Make sunxi_pconf_group_set use
 sunxi_pconf_reg helper
In-Reply-To: <20161111095036.11803-4-wens@csie.org>
References: <20161111095036.11803-1-wens@csie.org>
 <20161111095036.11803-4-wens@csie.org>
Message-ID: <CACRpkda3EF8GDVE=9cCy2z+4on3kXN13Zs0RKSNqWbQi44BcYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 10:50 AM, Chen-Yu Tsai <wens@csie.org> wrote:

> The sunxi_pconf_reg helper introduced in the last patch gives us the
> chance to rework sunxi_pconf_group_set to have it match the structure
> of sunxi_pconf_(group_)get and make it easier to understand.
>
> For each config to set, it:
>
>     1. checks if the parameter is supported.
>     2. checks if the argument is within limits.
>     3. converts argument to the register value.
>     4. writes to the register with spinlock held.
>
> As a result the function now blocks unsupported config parameters,
> instead of silently ignoring them.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
