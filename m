From: mturquette@baylibre.com (Michael Turquette)
Date: Fri, 19 Feb 2016 08:18:50 -0800
Subject: [PATCH] clk: gpio: Really allow an optional clock= DT property
In-Reply-To: <1455851525-18972-1-git-send-email-sboyd@codeaurora.org>
References: <20160219030731.GS4847@codeaurora.org>
 <1455851525-18972-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CAEG3pNAee6e7nnnCB334zecADV58yfcJ5azUjALHaDP40B_pLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 7:12 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>
> We mis-merged the original patch from Russell here and so the
> patch went almost all the way, except that we still failed to
> probe when there wasn't a clocks property in the DT node. Allow
> that case by making a negative value from
> of_clk_get_parent_count() into "no parents", like the original
> patch did.
>
> Fixes: 7ed88aa2efa5 ("clk: fix clk-gpio.c with optional clock= DT property")
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Ack.

Regards,
Mike

> ---
>  drivers/clk/clk-gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
> index 19fed65587e8..7b09a265d79f 100644
> --- a/drivers/clk/clk-gpio.c
> +++ b/drivers/clk/clk-gpio.c
> @@ -289,7 +289,7 @@ static void __init of_gpio_clk_setup(struct device_node *node,
>
>         num_parents = of_clk_get_parent_count(node);
>         if (num_parents < 0)
> -               return;
> +               num_parents = 0;
>
>         data = kzalloc(sizeof(*data), GFP_KERNEL);
>         if (!data)
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>



-- 
Michael Turquette
CEO
BayLibre - At the Heart of Embedded Linux
http://baylibre.com/
