From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 31 Dec 2014 17:34:43 +0100
Subject: [PATCH] ASoC: adi: Add missing return statement.
In-Reply-To: <1420042837-3337-1-git-send-email-andrew.jackson@arm.com>
References: <1420042837-3337-1-git-send-email-andrew.jackson@arm.com>
Message-ID: <54A425A3.2070108@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/31/2014 05:20 PM, Andrew Jackson wrote:
> From: Andrew Jackson <Andrew.Jackson@arm.com>
>
> The probe routine was disabling the clock even
> if the system was configured successfully.  Add
> a return statement to leave clocks enabled.
>
> Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks, never noticed since the clock is shared with other peripherals.

> ---
> Spotted while reviewing clock preparation
>
>   sound/soc/adi/axi-i2s.c |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/adi/axi-i2s.c b/sound/soc/adi/axi-i2s.c
> index 7752860..4c23381 100644
> --- a/sound/soc/adi/axi-i2s.c
> +++ b/sound/soc/adi/axi-i2s.c
> @@ -240,6 +240,8 @@ static int axi_i2s_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto err_clk_disable;
>
> +	return 0;
> +
>   err_clk_disable:
>   	clk_disable_unprepare(i2s->clk);
>   	return ret;
>
