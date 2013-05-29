From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 29 May 2013 21:12:35 +0800
Subject: [PATCH v6 07/10] ASoC: fsl-ssi: imx ac97 support
In-Reply-To: <1369752478-30260-8-git-send-email-mpa@pengutronix.de>
References: <1369752478-30260-1-git-send-email-mpa@pengutronix.de>
 <1369752478-30260-8-git-send-email-mpa@pengutronix.de>
Message-ID: <20130529131233.GA29528@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 04:47:55PM +0200, Markus Pargmann wrote:
> +struct snd_ac97_bus_ops soc_ac97_ops = {
> +	.read		= fsl_ssi_ac97_read,
> +	.write		= fsl_ssi_ac97_write,
> +};
> +EXPORT_SYMBOL_GPL(soc_ac97_ops);

I'm seeing the following compile error.

  LD      sound/soc/fsl/built-in.o
sound/soc/fsl/snd-soc-imx-ssi.o: In function `__crc_soc_ac97_ops':
imx-ssi.c:(*ABS*+0xd390d3c4): multiple definition of `__crc_soc_ac97_ops'
sound/soc/fsl/snd-soc-imx-ssi.o:(.data+0x168): multiple definition of `soc_ac97_ops'
sound/soc/fsl/snd-soc-fsl-ssi.o:(.data+0x0): first defined here
make[4]: *** [sound/soc/fsl/built-in.o] Error 1

Shawn
