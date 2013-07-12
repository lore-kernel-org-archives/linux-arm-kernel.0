From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Jul 2013 12:49:26 +0100
Subject: [PATCH v5 2/7] sound: sam9x5_wm8731: machine driver for
 at91sam9x5 wm8731 boards
In-Reply-To: <1373559359-31607-3-git-send-email-richard.genoud@gmail.com>
References: <1373559359-31607-1-git-send-email-richard.genoud@gmail.com>
 <1373559359-31607-3-git-send-email-richard.genoud@gmail.com>
Message-ID: <20130712114926.GE24508@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 06:15:54PM +0200, Richard Genoud wrote:
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Description of the Asoc machine driver for an at91sam9x5 based board

ASoC.

> +sam9x5 pins:
> + * LOUT
> + * ROUT
> + * LHPOUT
> + * RHPOUT
> + * LLINEIN
> + * RLINEIN
> + * MICIN

These aren't pins on the CPU, they're pins on the CODEC, and you should
be adding this to the binding document for the CODEC and referring to
that rather than having them in each individual binding document.  This
also helps if any new variants are added (not that this is likely for
the WM8731).

> +static struct sam9x5_drvdata sam9x5_priv;

Why is this a global static?

> +	ret = snd_soc_register_card(&snd_soc_sam9x5);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"ASoC: Platform device allocation failed\n");
> +		goto out_put_audio;
> +	}

> +	platform_set_drvdata(pdev, &snd_soc_sam9x5);

It should be being dynamically allocated and retrieved as driver data
when needed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130712/2edc0bad/attachment.sig>
