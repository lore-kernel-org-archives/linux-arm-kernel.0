From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 12 Mar 2013 18:55:10 +0000
Subject: [PATCH 04/10] ASoC: Kconfig: imx-ssi needs imx-fiq and imx-dma
In-Reply-To: <1362940391-8338-5-git-send-email-mpa@pengutronix.de>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-5-git-send-email-mpa@pengutronix.de>
Message-ID: <20130312185510.GV19942@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 10, 2013 at 07:33:05PM +0100, Markus Pargmann wrote:

>  config SND_SOC_IMX_SSI
> +	select SND_SOC_IMX_PCM_DMA
> +	select SND_SOC_IMX_PCM_FIQ
>  	tristate

Really?  I'd expect this to be an or, if we've got DMA I can't see any
reason why we'd want to use the FIQ.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130312/b3a00acb/attachment.sig>
