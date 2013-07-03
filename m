From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Jul 2013 17:06:37 +0100
Subject: [PATCH v9 04/10] ASoC: fsl-ssi: Add support for imx-pcm-fiq
In-Reply-To: <1371734429-6081-5-git-send-email-mpa@pengutronix.de>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-5-git-send-email-mpa@pengutronix.de>
Message-ID: <20130703160637.GQ27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 03:20:23PM +0200, Markus Pargmann wrote:

> +	ssi_private->use_dma = !of_property_read_bool(np, "fsl,imx-fiq");
> +

This binding should be documented.  I'm not sure it really needs to be
a binding, though - is it not possible for the driver to just figure out
that DMA won't work automatically (for example by looking at the CODEC
in use)?  I'm not sure this is a good name either, it should be saying
why the FIQ is needed rather than saying that we should use the FIQ.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130703/3c369fbd/attachment.sig>
