From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 27 Jan 2017 09:42:13 -0800
Subject: [PATCH 1/3] mmc: meson-gx: fix setting f_min
In-Reply-To: <e26a74f8-9819-6940-4c90-225377cc0a3e@gmail.com> (Heiner
 Kallweit's message of "Thu, 26 Jan 2017 22:41:15 +0100")
References: <e26a74f8-9819-6940-4c90-225377cc0a3e@gmail.com>
Message-ID: <m28tpwwgay.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Currently f_min is set to 4 MHz whilst the comment states 400 MHz.
> I think the itention is to set f_min to 400 kHz.

Yes indeed.  

> Change value and comment accordingly.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index bf19d03c..cf071756 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -268,7 +268,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>  	if (f_min != UINT_MAX)
>  		f_min = DIV_ROUND_UP(CLK_SRC_XTAL_RATE, CLK_DIV_MAX);
>  	else
> -		f_min = 4000000;  /* default min: 400 MHz */
> +		f_min = 400000;  /* default min: 400 kHz */
>  	host->mmc->f_min = f_min;
>  
>  	/* create the mux */
