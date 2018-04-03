From: ladis@linux-mips.org (Ladislav Michl)
Date: Tue, 3 Apr 2018 15:45:40 +0200
Subject: [alsa-devel] [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake:
 "Stoping" -> "Stopping"
In-Reply-To: <20180330154420.6903-1-colin.king@canonical.com>
References: <20180330154420.6903-1-colin.king@canonical.com>
Message-ID: <20180403134540.GA29017@lenoch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2018 at 04:44:20PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>

Hello Colin,

> Trivial fix to spelling mistake in pr_debug message text

would you mind making this patch a bit less non-trivial and
change pr_debug to dev_dbg dropping Atmel_ssc_dai prefix?

Thank you.

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/soc/atmel/atmel_ssc_dai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index a1e2c5682dcd..1c7af0ca98ec 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -820,7 +820,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
>  		if (ret < 0) {
>  			printk(KERN_WARNING
>  					"atmel_ssc_dai: request_irq failure\n");
> -			pr_debug("Atmel_ssc_dai: Stoping clock\n");
> +			pr_debug("Atmel_ssc_dai: Stopping clock\n");
>  			clk_disable(ssc_p->ssc->clk);
>  			return ret;
>  		}
> -- 
> 2.15.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
