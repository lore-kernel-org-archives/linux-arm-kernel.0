From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Apr 2013 12:59:43 +0100
Subject: [PATCH v3 05/15] ASoC: phycore-ac97: Add DT support
In-Reply-To: <1365939779-4507-6-git-send-email-mpa@pengutronix.de>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
 <1365939779-4507-6-git-send-email-mpa@pengutronix.de>
Message-ID: <20130416115942.GG26958@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 14, 2013 at 01:42:49PM +0200, Markus Pargmann wrote:

> +	/*
> +	 * This driver doesn't need to know which actual hardware is used.
> +	 * The audmux driver has knowledge about it's type, and returns
> +	 * an error if executed on the wrong type of hardware.
> +	 */
> +	ret = phycore_ac97_pca100_audmux();
> +	if (!ret)
> +		return 0;
> +
> +	ret = phycore_ac97_pcm043_audmux();

The DT really ought to be able to give enough information to figure out
the audmux configuration.  If we can't do that it rather defeats the
point of moving to DT...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130416/c8e2f1bc/attachment.sig>
