From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Dec 2013 13:03:34 +0000
Subject: [PATCH v3 1/9] ASoC: fsl-ssi: Fix probe error handling
In-Reply-To: <1387367865-26391-2-git-send-email-mpa@pengutronix.de>
References: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
 <1387367865-26391-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20131219130334.GZ31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 12:57:37PM +0100, Markus Pargmann wrote:
> This patch fixes the error handling in the fsl-ssi probe function.

This doesn't apply against current code, please check and resend.

>  error_irqmap:
> -	irq_dispose_mapping(ssi_private->irq);
> +	if (ssi_private->use_dma && !of_device_is_compatible(pdev->dev.of_node,
> +				"fsl,imx21-ssi"))
> +		irq_dispose_mapping(ssi_private->irq);

This test is icky, a flag set when we create the mapping would be neter.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131219/d4b71001/attachment.sig>
