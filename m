From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 26 Mar 2014 17:14:28 -0300
Subject: [PATCH] clk: register fixed-clock only if #clock-cells property
 is present
In-Reply-To: <53333145.4080903@gmail.com>
References: <1395858127-18730-1-git-send-email-s.nawrocki@samsung.com>
 <CAOMZO5DJPKvha7A-foktsB2dEw9xGXL_++uBXj_3ScAPTXNOkw@mail.gmail.com>
 <53333145.4080903@gmail.com>
Message-ID: <CAOMZO5AEry8sJW_+0aJS8ush+sYPPWk9LRU0b8RUUGa-hO_G1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 4:57 PM, Sylwester Nawrocki
<sylvester.nawrocki@gmail.com> wrote:

> Perhaps a change as below helps ?
>
> From 85ee85e4a92b42442354f3f2454be50c173e1c59 Mon Sep 17 00:00:00 2001
> From: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Date: Wed, 26 Mar 2014 20:54:13 +0100
> Subject: [PATCH] clk: reverse default clk provider initialization order in
> of_clk_init()
>
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/clk/clk.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index fb3c40b..d30809c 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2608,7 +2608,7 @@ void __init of_clk_init(const struct of_device_id
> *matches)
>
>                 parent->clk_init_cb = match->data;
>                 parent->np = np;
> -               list_add(&parent->node, &clk_provider_list);
> +               list_add_tail(&parent->node, &clk_provider_list);
>         }
>
>         while (!list_empty(&clk_provider_list)) {

Thanks, Sylwester!

This makes my imx6q-wandboard to boot again.

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
