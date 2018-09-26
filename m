From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 27 Sep 2018 01:47:44 +0200
Subject: [PATCH] mmc: core: Fix debounce time to use microseconds
In-Reply-To: <20180918231656.21778-1-tony@atomide.com>
References: <20180918231656.21778-1-tony@atomide.com>
Message-ID: <CAPDyKFqOYNAC5GHPsWbganZ7BjHD67OSqrxxCwu1nXzrLRhFMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 September 2018 at 01:16, Tony Lindgren <tony@atomide.com> wrote:
> The debounce value in device tree is in milliseconds but needs to be in
> microseconds for mmc_gpiod_request_cd().
>
> Fixes: bfd694d5e21c ("mmc: core: Add tunable delay before detecting card
> after card is inserted")
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -235,7 +235,7 @@ int mmc_of_parse(struct mmc_host *host)
>                         host->caps |= MMC_CAP_NEEDS_POLL;
>
>                 ret = mmc_gpiod_request_cd(host, "cd", 0, true,
> -                                          cd_debounce_delay_ms,
> +                                          cd_debounce_delay_ms * 1000,
>                                            &cd_gpio_invert);
>                 if (!ret)
>                         dev_info(host->parent, "Got CD GPIO\n");
> --
> 2.19.0
