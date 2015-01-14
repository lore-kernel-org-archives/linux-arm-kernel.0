From: davem@davemloft.net (David Miller)
Date: Tue, 13 Jan 2015 23:06:11 -0500 (EST)
Subject: [PATCH net-next v12 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <1421140290-5492-4-git-send-email-dingtianhong@huawei.com>
References: <1421140290-5492-1-git-send-email-dingtianhong@huawei.com>
 <1421140290-5492-4-git-send-email-dingtianhong@huawei.com>
Message-ID: <20150113.230611.375062426344934847.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ding Tianhong <dingtianhong@huawei.com>
Date: Tue, 13 Jan 2015 17:11:30 +0800

> +static int hip04_alloc_ring(struct net_device *ndev, struct device *d)
> +{
> +	struct hip04_priv *priv = netdev_priv(ndev);
> +	int i;
> +
> +	priv->tx_desc = dma_alloc_coherent(d,
> +			TX_DESC_NUM * sizeof(struct tx_desc),
> +			&priv->tx_desc_dma, GFP_KERNEL);

When a function call spans multiple lines, the arguments on the
second and subsequent lines should start at the first column
after the openning parenthesis of the function call.

If you are only using TAB characters, your indentation is likely
to be incorrect.

> +	/*
> +	 * BQL will try to keep the TX queue as short as possible, but it can't
> +	 * be faster than tx_coalesce_usecs, so we need a fast timeout here,
> +	 * but also long enough to gather up enough frames to ensure we don't
> +	 * get more interrupts than necessary.
> +	 * 200us is enough for 16 frames of 1500 bytes at gigabit ethernet rate
> +	 */

Comments in the networking should be:

	/* Formatted
	 * like this.
	 */

> +	priv->phy_node = of_parse_phandle(node, "phy-handle", 0);
> +	if (priv->phy_node) {
> +		priv->phy = of_phy_connect(ndev, priv->phy_node,
> +			&hip04_adjust_link, 0, priv->phy_mode);

Please align the arguments to this function call correctly, as
per above.

Thanks.
