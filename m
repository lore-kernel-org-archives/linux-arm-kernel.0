From: davem@davemloft.net (David Miller)
Date: Sun, 08 Apr 2018 12:42:00 -0400 (EDT)
Subject: [PATCH v4] net: thunderx: rework mac addresses list to u64 array
In-Reply-To: <20180406195354.16037-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180406140443.15181-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180406195354.16037-1-Vadim.Lomovtsev@caviumnetworks.com>
Message-ID: <20180408.124200.2204489876311923873.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Date: Fri,  6 Apr 2018 12:53:54 -0700

> @@ -1929,7 +1929,7 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
>  						  work.work);
>  	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
>  	union nic_mbx mbx = {};
> -	struct xcast_addr *xaddr, *next;
> +	int idx = 0;

No need to initialize idx.

> +		for (idx = 0; idx < vf_work->mc->count; idx++) {

As it is always explicitly initialized at, and only used inside of,
this loop.
