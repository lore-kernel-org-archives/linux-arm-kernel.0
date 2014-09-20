From: varkabhadram@gmail.com (Varka Bhadram)
Date: Sat, 20 Sep 2014 21:10:08 +0530
Subject: [PATCH v3 1/2] bcma: register bcma as device tree driver
In-Reply-To: <1411218125-32670-1-git-send-email-hauke@hauke-m.de>
References: <1411218125-32670-1-git-send-email-hauke@hauke-m.de>
Message-ID: <541D9FD8.4000404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 September 2014 06:32 PM, Hauke Mehrtens wrote:
> This driver is used by the bcm53xx ARM SoC code. Now it is possible to
> give the address of the chipcommon core in device tree and bcma will
> search for all the other cores.

(...)

> +
> +static const struct of_device_id bcma_host_soc_of_match[] = {
> +	{ .compatible = "brcm,bus-axi", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, bcma_host_soc_of_match);
> +
> +static struct platform_driver bcma_host_soc_driver = {
> +	.driver = {
> +		.name = "bcma-host-soc",
> +		.owner = THIS_MODULE,

This field updated automatically...

> +		.of_match_table = bcma_host_soc_of_match,
> +	},
> +	.probe		= bcma_host_soc_probe,
> +	.remove		= bcma_host_soc_remove,
> +};
> +
> +int __init bcma_host_soc_register_driver(void)
> +{
> +	return platform_driver_register(&bcma_host_soc_driver);
> +}
> +
> +void __exit bcma_host_soc_unregister_driver(void)
> +{
> +	platform_driver_unregister(&bcma_host_soc_driver);
> +}
> +#endif /* CONFIG_OF */

Why dont you use module_platform_driver(...)...?

-- 
Regards,
Varka Bhadram.
