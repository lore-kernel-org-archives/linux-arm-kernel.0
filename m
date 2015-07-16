From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 16 Jul 2015 10:05:44 +0200
Subject: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
In-Reply-To: <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1437033944.27428.11.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On wo, 2015-07-15 at 11:15 +0800, Xing Zheng wrote:
> --- /dev/null
> +++ b/sound/soc/rockchip/rockchip_max98090.c

> +#define DRV_NAME "rockchip-snd-max98090"

> +static const struct of_device_id rockchip_max98090_of_match[] = {
> +	{ .compatible = "rockchip,rockchip-audio-max98090", },
> +	{},
> +};
> +
> +static struct platform_driver snd_rk_mc_driver = {
> +	.probe = snd_rk_mc_probe,
> +	.remove = snd_rk_mc_remove,
> +	.driver = {
> +		.name = DRV_NAME,
> +		.owner = THIS_MODULE,
> +		.pm = &snd_soc_pm_ops,
> +		.of_match_table = rockchip_max98090_of_match,
> +	},
> +};
> +
> +module_platform_driver(snd_rk_mc_driver);

Nit: empty line here.

> +MODULE_AUTHOR("jianqun <jay.xu@rock-chips.com>");
> +MODULE_DESCRIPTION("Rockchip max98090 machine ASoC driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" DRV_NAME);

This seems only useful if there's a corresponding struct
platform_device. Ie, a platform_device with a "rockchip-snd-max98090"
.name, which will trigger a "MODALIAS=platform:rockchip-snd-max98090"
uevent when it's created. But I couldn't find where such a
platform_device is created.

Did I miss something? Or is there another way this alias is useful here?

> +MODULE_DEVICE_TABLE(of, rockchip_max98090_of_match);

The common pattern is to put MODULE_DEVICE_TABLE() directly after the
table it exports.

Likewise for 2/2 (except the empty line nit, that is).

Thanks,


Paul Bolle
