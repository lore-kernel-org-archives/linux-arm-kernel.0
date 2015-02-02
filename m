From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 2 Feb 2015 20:00:41 +0100
Subject: [PATCH] mmc: core: Invoke mmc_pwrseq_post_power_on() prior
 MMC_POWER_ON state
In-Reply-To: <1422892854-3655-1-git-send-email-ulf.hansson@linaro.org>
References: <1422892854-3655-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CABxcv==yr9ssqZisOUL1MYNSjPQG=fLw+JwXtKgPLap9BmZudg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ulf,

On Mon, Feb 2, 2015 at 5:00 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Host drivers have different ways to sends their "init stream" to the
> card. Some need to do it as part of a request, some do it from the
> ->set_ios() callback in the MMC_POWER_ON state and some don't send an
> "init stream" at all.
>
> To be able to use the reset GPIOs from the simple MMC power sequence
> provider, the card need to be powered and the "init stream" must not
> have been sent.
>
> To cope with these requirements, invoke mmc_pwrseq_post_power_on()
> prior we change the state to MMC_POWER_ON in mmc_power_up().
>
> Host drivers shall perform power up operations in the MMC_POWER_UP
> state. Unfortunate three hosts (au1xmmc, cb710-mmc and toshsd) don't
> conform to this expectation. Instead those ignore the MMC_POWER_UP
> state and delays their power up operations to the MMC_POWER_ON state.
>
> Those hosts needs to change their behavior to enable proper support for
> the simple MMC power sequence provider.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

The patch looks good to me and I tested that the WLAN chip attached to
the SDIO interface in my Exynos5250 Snow Chromebook is reset / powered
up correctly so:

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
