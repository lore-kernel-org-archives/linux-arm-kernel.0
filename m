From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 May 2015 12:53:52 +0200
Subject: [PATCH 2/2] ASoC: atmel: compile pcm driver in
 snd-soc-atmel_ssc_dai
In-Reply-To: <1432591459-22613-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1432591459-22613-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1432591459-22613-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <4338609.rFs5DCIUWR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 May 2015 00:04:19 Alexandre Belloni wrote:
> index b327e5cc8de3..4fa7ac91f972 100644
> --- a/sound/soc/atmel/Makefile
> +++ b/sound/soc/atmel/Makefile
> @@ -1,10 +1,8 @@
>  # AT91 Platform Support
> -snd-soc-atmel-pcm-pdc-objs := atmel-pcm-pdc.o
> -snd-soc-atmel-pcm-dma-objs := atmel-pcm-dma.o
> -snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o
> +snd-soc-atmel-pcm-$(CONFIG_SND_ATMEL_SOC_PDC) := atmel-pcm-pdc.o
> +snd-soc-atmel-pcm-$(CONFIG_SND_ATMEL_SOC_DMA) += atmel-pcm-dma.o
> +snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o $(snd-soc-atmel-pcm-y)

While technically correct, you could have written this (slightly)
simpler as:

snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o
snd-soc-atmel-ssc_dai-$(CONFIG_SND_ATMEL_SOC_PDC) += atmel-pcm-pdc.o
snd-soc-atmel-ssc_dai-$(CONFIG_SND_ATMEL_SOC_DMA) += atmel-pcm-dma.o

No need to change the patch again after it's applied now.

	Arnd
