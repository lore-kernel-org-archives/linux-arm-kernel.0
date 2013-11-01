From: broonie@kernel.org (Mark Brown)
Date: Fri, 1 Nov 2013 11:40:08 -0700
Subject: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio machine driver.
In-Reply-To: <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20131101184008.GF2493@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 01, 2013 at 03:04:53PM +0800, Xiubo Li wrote:

> Conflicts:
> 	sound/soc/fsl/Makefile

Ahem.

> +	/* TODO: The SAI driver should figure this out for us */
> +	switch (channels) {
> +	case 2:
> +		snd_soc_dai_set_tdm_slot(cpu_dai, 0xfffffffc, 0xfffffffc, 2, 0);
> +		break;
> +	case 1:
> +		snd_soc_dai_set_tdm_slot(cpu_dai, 0xfffffffe, 0xfffffffe, 1, 0);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

Yes, it should - this code should probably just be copied straight into
the SAI driver.  If we need to support other configurations we can do
that later.

> +static int fsl_sgtl5000_remove(struct platform_device *pdev)
> +{
> +	snd_soc_unregister_card(&fsl_sgt1500_card);
> +
> +	return 0;
> +}

You're using snd_soc_unregister_card() so you don't need to do this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131101/9f61e6ef/attachment.sig>
