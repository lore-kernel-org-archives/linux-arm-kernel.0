From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Sep 2012 11:32:52 +0000
Subject: [PATCH 33/34] ARM: imx: remove header file mach/irqs.h
In-Reply-To: <1347860103-4141-34-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-34-git-send-email-shawn.guo@linaro.org>
Message-ID: <201209171132.52380.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 September 2012, Shawn Guo wrote:
> @@ -269,6 +268,8 @@ static int imx_pcm_fiq_new(struct snd_soc_pcm_runtime *rtd)
>         return 0;
>  }
>  
> +extern int mxc_set_irq_fiq(unsigned int irq, unsigned int type);
> +
>  static void imx_pcm_fiq_free(struct snd_pcm *pcm)
>  {
>         mxc_set_irq_fiq(ssi_irq, 0);

Hmm, this is quite hacky, I can see why you left it all the way
to the end of the otherwise excellent series ;-)

We already have some fiq specific stuff in the
include/linux/platform_data/asoc-imx-ssi.h header file,
so I think it's best to put this declaration there, too.

If we want to eventually clean up the fiq usage in this driver,
I think we should extend the DT binding for the interrupt controller
to describe the fiq correctly so it can all be done transparently.

	Arnd
