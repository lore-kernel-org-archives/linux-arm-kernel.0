From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 30 Dec 2015 13:03:58 -0800
Subject: [PATCH v4 03/24] clk: pwm: use pwm_get_xxx() helpers where
 appropriate
In-Reply-To: <1447664207-24370-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447664207-24370-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151230210358.19557.32933@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Quoting Boris Brezillon (2015-11-16 00:56:26)
> diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
> index 328fcfc..b6306a2 100644
> --- a/drivers/clk/clk-pwm.c
> +++ b/drivers/clk/clk-pwm.c
> @@ -71,22 +71,23 @@ static int clk_pwm_probe(struct platform_device *pdev)
>         if (IS_ERR(pwm))
>                 return PTR_ERR(pwm);
>  
> -       if (!pwm->period) {
> +       if (!pwm_get_period((pwm))) {

The change itself looks fine, but the semantic patch added extra parens.
Can you remove them? After doing so feel free to add:

Acked-by: Michael Turquette <mturquette@baylibre.com>
