From: davem@davemloft.net (David Miller)
Date: Mon, 29 Sep 2014 16:04:36 -0400 (EDT)
Subject: [PATCH v5 02/10] net: pxa168_eth: add device tree support
In-Reply-To: <1411742036-23520-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1411742036-23520-1-git-send-email-antoine.tenart@free-electrons.com>
 <1411742036-23520-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140929.160436.1932620234954504510.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>
Date: Fri, 26 Sep 2014 16:33:48 +0200

> @@ -1603,6 +1620,12 @@ static int pxa168_eth_suspend(struct platform_device *pdev, pm_message_t state)
>  #define pxa168_eth_suspend NULL
>  #endif
>  
> +static const struct of_device_id pxa168_eth_of_match[] = {
> +	{ .compatible = "marvell,pxa168-eth" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, pxa168_eth_of_match)
> +
>  static struct platform_driver pxa168_eth_driver = {

You didn't even compile test this change with module support enabled.

drivers/net/ethernet/marvell/pxa168_eth.c:1670:1: error: expected ?,? or ?;? before ?static?

MODULE_DEVICE_TABLE() must be completed with a trailing ';'
