From: davem@davemloft.net (David Miller)
Date: Tue, 26 Dec 2017 12:58:15 -0500 (EST)
Subject: [PATCH net-next v7 2/2] net: ethernet: socionext: add AVE
 ethernet driver
In-Reply-To: <1513854776-4149-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1513854776-4149-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1513854776-4149-3-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <20171226.125815.447371237720916939.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Thu, 21 Dec 2017 20:12:56 +0900

> +	writel(AVE_TXDC_ADDR_START
> +		| (((priv->tx.ndesc * priv->desc_size) << 16) & AVE_TXDC_SIZE),
> +		priv->base + AVE_TXDC);
...
> +	writel(AVE_RXDC0_ADDR_START
> +	       | (((priv->rx.ndesc * priv->desc_size) << 16) & AVE_RXDC0_SIZE),
> +	       priv->base + AVE_RXDC0);
 ...
> +	cmdsts = AVE_STS_OWN | AVE_STS_1ST | AVE_STS_LAST
> +		| (skb->len & AVE_STS_PKTLEN_TX_MASK);

Please do not begin lines with operators, instead put them at the end
of the previous line, f.e.:

	cmdsts = AVE_STS_OWN | AVE_STS_1ST | AVE_STS_LAST |
		 (skb->len & AVE_STS_PKTLEN_TX_MASK);

Thank you.
