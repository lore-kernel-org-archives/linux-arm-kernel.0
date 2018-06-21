From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Thu, 21 Jun 2018 11:54:43 +0900
Subject: [PATCH] ASoC: uniphier: remove redundant check of PLL ID
In-Reply-To: <20180621024346.13131-1-suzuki.katsuhiro@socionext.com>
References: <20180621024346.13131-1-suzuki.katsuhiro@socionext.com>
Message-ID: <001e01d4090b$34b3b5f0$9e1b21d0$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I got mistake (forget to remove unused variable).
I'll send v2. Sorry for confusing.

Regards,
--
Katsuhiro Suzuki


> -----Original Message-----
> From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> Sent: Thursday, June 21, 2018 11:44 AM
> To: Mark Brown <broonie@kernel.org>; alsa-devel at alsa-project.org
> Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>; Jassi Brar
> <jaswinder.singh@linaro.org>; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; Suzuki, Katsuhiro/?? ??
> <suzuki.katsuhiro@socionext.com>
> Subject: [PATCH] ASoC: uniphier: remove redundant check of PLL ID
> 
> This patch removes redudant check of PLL ID. struct uniphier_aio_pll
> enable member has already been checked at is_valid_pll().
> 
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---
>  sound/soc/uniphier/aio-cpu.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
> index 2d9b7dde2ffa..cfe69ab44b63 100644
> --- a/sound/soc/uniphier/aio-cpu.c
> +++ b/sound/soc/uniphier/aio-cpu.c
> @@ -224,10 +224,6 @@ static int uniphier_aio_set_pll(struct snd_soc_dai *dai,
int
> pll_id,
> 
>  	if (!is_valid_pll(aio->chip, pll_id))
>  		return -EINVAL;
> -	if (!aio->chip->plls[pll_id].enable) {
> -		dev_err(dev, "PLL(%d) is not implemented\n", pll_id);
> -		return -ENOTSUPP;
> -	}
> 
>  	ret = aio_chip_set_pll(aio->chip, pll_id, freq_out);
>  	if (ret < 0)
> --
> 2.17.1
