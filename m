From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Dec 2013 18:37:43 +0000
Subject: [PATCHv3 5/7] ASoC: fsl: Add SGTL5000 based audio machine driver.
In-Reply-To: <1387250684-23406-6-git-send-email-Li.Xiubo@freescale.com>
References: <1387250684-23406-1-git-send-email-Li.Xiubo@freescale.com>
 <1387250684-23406-6-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20131218183743.GG31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 11:24:42AM +0800, Xiubo Li wrote:

> This is the SGTL5000 codec based audio driver supported with both
> playback and capture dai link implemention.

> This implementation is only compatible with device tree definition.

It looks like these cards should be supportable using the generic simple
card bindings that Morimoto-san implemented, you can see these in -next
as "ASoC: simple-card: add Device Tree support".  Can you check to see
if that's the case?  If it is you'll still need Kconfig to enable
building the SoC and CODEC drivers.
 
> +menuconfig SND_FSL_SOC
> +	tristate "SoC Audio for Freescale VF610 CPUs"
> +	help
> +	  Say Y or M if you want to add support for codecs attached to
> +	  the VF610 CPUs.
> +
> +	  This will enable Freeacale SAI and SGTL5000 codec, and an extra
> +	  TWR-AUDIO-SGTL sub-board is needed for SGTL5000.

This should select the dmaengine helpers (and should really have been
split out as part of the first patch).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/7b6e6675/attachment-0001.sig>
