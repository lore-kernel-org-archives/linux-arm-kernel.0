From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Apr 2014 21:52:16 +0200
Subject: [PATCH] ASoC: fsl: select SND_SOC_IMX_PCM_DMA where needed
In-Reply-To: <1398710770.235891074@f303.i.mail.ru>
References: <6606961.lAGLvkNsEj@wuerfel> <1398710770.235891074@f303.i.mail.ru>
Message-ID: <7785150.X1QaggmPtm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 April 2014 22:46:10 Alexander Shiyan wrote:
> Mon, 28 Apr 2014 16:46:30 +0200 ?? Arnd Bergmann <arnd@arndb.de>:
> > Since commit 204dec93eaa "ASoC: fsl: Allow to select individual common
> > options", it is possible to enable SND_SOC_FSL_SSI and SND_SOC_FSL_SPDIF
> > manually. However, these two options are for drivers that both
> > require the imx-pcm-dma framework and result in a link error if that
> > is not provided.
> > 
> > This changes Kconfig to automatically select SND_SOC_IMX_PCM_DMA
> > to avoid the problem, as we do for other drivers that need the same
> > framework.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Can you give an exact error?


sound/built-in.o: In function `fsl_ssi_probe':
:(.text+0x51fb8): undefined reference to `imx_pcm_dma_init'
sound/built-in.o: In function `fsl_spdif_probe':
:(.text+0x52e20): undefined reference to `imx_pcm_dma_init'
