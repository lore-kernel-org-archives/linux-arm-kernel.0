From: davem@davemloft.net (David Miller)
Date: Sat, 07 Jul 2018 11:09:00 +0900 (KST)
Subject: [PATCH net-next 3/6] net: mvneta: discriminate error cause for
 missed packet
In-Reply-To: <20180706131949.2684-4-gregory.clement@bootlin.com>
References: <20180706131949.2684-1-gregory.clement@bootlin.com>
 <20180706131949.2684-4-gregory.clement@bootlin.com>
Message-ID: <20180707.110900.1021780626656230934.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Fri,  6 Jul 2018 15:19:46 +0200

> @@ -609,6 +606,10 @@ struct mvneta_rx_queue {
>  
>  	/* Index of the next RX DMA descriptor to process */
>  	int next_desc_to_proc;
> +
> +	/* error counters */
> +	u32 skb_alloc_err;
> +	u32 refill_err;
>  };

These counters aren't exported anywhere, making them not so useful.

Either remove this stuff or add them to the driver's ethtool state.

Thank you.
