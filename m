From: davem@davemloft.net (David Miller)
Date: Mon, 15 Sep 2014 17:32:47 -0400 (EDT)
Subject: [Patch net-next 1/4] net: fec: refine error handle of parser
 queue number from DT
In-Reply-To: <1410801177-15872-2-git-send-email-Frank.Li@freescale.com>
References: <1410801177-15872-1-git-send-email-Frank.Li@freescale.com>
 <1410801177-15872-2-git-send-email-Frank.Li@freescale.com>
Message-ID: <20140915.173247.59215420475562894.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: <Frank.Li@freescale.com>
Date: Tue, 16 Sep 2014 01:12:54 +0800

> -		dev_err(&pdev->dev, "Invalidate num_tx(=%d), fail back to 1\n",
> +		dev_warn(&pdev->dev, "Invalid num_tx(=%d), fall back to 1\n",
>  			*num_tx);

Any time you change the function name of a multi-line function call, you must
be mindful to adjust the indention of the subsequent argument lines, if
necessary.

>  	if (*num_rx < 1 || *num_rx > FEC_ENET_MAX_RX_QS) {
> -		dev_err(&pdev->dev, "Invalidate num_rx(=%d), fail back to 1\n",
> +		dev_warn(&pdev->dev, "Invalid num_rx(=%d), fall back to 1\n",
>  			*num_rx);

Likewise.
