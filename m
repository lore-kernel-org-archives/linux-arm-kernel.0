From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 29 Jul 2015 10:51:48 +0200
Subject: [PATCH 2/4] ASoc: rockchip: Add rockchip SPDIF transceiver driver
In-Reply-To: <1438085011-16577-3-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1438085011-16577-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1438085011-16577-3-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1438159908.5106.32.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A nit and a question.

On di, 2015-07-28 at 14:03 +0200, Sjoerd Simons wrote:
> --- /dev/null
> +++ b/sound/soc/rockchip/rockchip_spdif.c

> +#define DRV_NAME "rockchip-spdif"

> +static const struct of_device_id rockchip_spdif_match[] = {
> +	{ .compatible = "rockchip,rk3066-spdif", },
> +	{},
> +};

I didn't spot
    MODULE_DEVICE_TABLE(of, rockchip_spdif_match);

at first. It turned out that that line can be found at the bottom of
this file. Please put it here.

> +static struct platform_driver rockchip_spdif_driver = {
> +	.probe = rockchip_spdif_probe,
> +	.remove = rockchip_spdif_remove,
> +	.driver = {
> +		.name = DRV_NAME,
> +		.of_match_table = of_match_ptr(rockchip_spdif_match),
> +		.pm = &rockchip_spdif_pm_ops,
> +	},
> +};
> +module_platform_driver(rockchip_spdif_driver);

> +MODULE_ALIAS("platform:" DRV_NAME);

(I seem to remember that Mark Brown is OK with this, at least for the
time being, but for future reference I'll ask the question anyway.) Is
there a corresponding struct platform_device with a "rockchip-spdif"
.name? Because if there's no such platform_device I think this line
doesn't really do anything for this driver.

> +MODULE_DEVICE_TABLE(of, rockchip_spdif_match);

Thanks,


Paul Bolle
