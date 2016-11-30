From: davem@davemloft.net (David Miller)
Date: Wed, 30 Nov 2016 14:11:21 -0500 (EST)
Subject: [PATCH net-next] net: thunderx: Fix transmit queue timeout issue
In-Reply-To: <1480419620-32500-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1480419620-32500-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <20161130.141121.375154493677208609.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: sunil.kovvuri@gmail.com
Date: Tue, 29 Nov 2016 17:10:20 +0530

> +		/* Check again, incase another cpu freed descriptors */
> +		if (atomic_read(&sq->free_cnt) > MIN_SQ_DESC_PER_PKT_XMIT) {
> +			netif_tx_start_queue(txq);

You have to use netif_tx_wake_queue() any time you restart a queue after bringing
the device up.
