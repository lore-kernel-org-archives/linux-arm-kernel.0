From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 7 Jun 2016 18:41:39 +0200
Subject: [PATCH] clk: at91: make of_sama5d2_clk_generated_setup() static
In-Reply-To: <1465317489-14920-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465317489-14920-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160607184139.69411eef@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  7 Jun 2016 17:38:09 +0100
Ben Dooks <ben.dooks@codethink.co.uk> wrote:

> The of_sama5d2_clk_generated_setup() is not exported outside
> of the driver, so make it static to fix the warning about it
> being not static:
> 
> drivers/clk/at91/clk-generated.c:270:13: warning: symbol 'of_sama5d2_clk_generated_setup' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-clk at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/clk/at91/clk-generated.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
> index e1aa210..7f6bec8 100644
> --- a/drivers/clk/at91/clk-generated.c
> +++ b/drivers/clk/at91/clk-generated.c
> @@ -267,7 +267,7 @@ at91_clk_register_generated(struct regmap *regmap,  spinlock_t *lock, const char
>  	return clk;
>  }
>  
> -void __init of_sama5d2_clk_generated_setup(struct device_node *np)
> +static void __init of_sama5d2_clk_generated_setup(struct device_node *np)
>  {
>  	int num;
>  	u32 id;



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
