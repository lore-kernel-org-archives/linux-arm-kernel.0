From: broonie@kernel.org (Mark Brown)
Date: Sat, 18 Jul 2015 10:16:08 +0100
Subject: [PATCH v2 1/2] ASoC: rockchip: Add machine driver for max98090
 codec
In-Reply-To: <1437196124-32655-2-git-send-email-zhengxing@rock-chips.com>
References: <1437196124-32655-1-git-send-email-zhengxing@rock-chips.com>
 <1437196124-32655-2-git-send-email-zhengxing@rock-chips.com>
Message-ID: <20150718091608.GW11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 18, 2015 at 01:08:43PM +0800, Xing Zheng wrote:

> +	ret = devm_snd_soc_register_card(&pdev->dev, card);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Soc register card failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int snd_rk_mc_remove(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *soc_card = platform_get_drvdata(pdev);
> +
> +	snd_soc_unregister_card(soc_card);

The point with using devm_snd_soc_register_card() is that you don't need
to manually unregister the card - devm_ ensures that the card is freed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150718/e389a870/attachment.sig>
