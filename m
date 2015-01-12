From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Jan 2015 09:21:05 +0100
Subject: [PATCH v6 1/2] mtd: hisilicon: add a new NAND controller driver
 for hisilicon hip04 Soc
In-Reply-To: <1421047734-30818-2-git-send-email-wangzhou1@hisilicon.com>
References: <1421047734-30818-1-git-send-email-wangzhou1@hisilicon.com>
 <1421047734-30818-2-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <5265608.Ut8IQVYZc5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 January 2015 15:28:53 Zhou Wang wrote:
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---

I haven't looked at earlier versions, but it looks very good to
me overall. Just add a patch description above please.

One tiny detail:

> +static const struct of_device_id nfc_id_table[] = {
> +	{ .compatible = "hisilicon,504-nfc" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, nfc_id_table);
> +
> +static struct platform_driver hisi_nfc_driver = {
> +	.driver = {
> +		.name  = "hisi_nand",
> +		.of_match_table = of_match_ptr(nfc_id_table),
> +		.pm = &hisi_nfc_pm_ops,
> +	},
> +	.probe		= hisi_nfc_probe,
> +	.remove		= hisi_nfc_remove,
> +};

Remove the of_match_ptr() macro here to avoid a warning when
CONFIG_OF is not set.

	Arnd
