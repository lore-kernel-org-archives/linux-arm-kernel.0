From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 5 Apr 2018 08:07:48 -0700
Subject: [PATCH] net: thunderx: rework mac addresses list to u64 array
In-Reply-To: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
Message-ID: <20180405150748.GA5716@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  struct xcast_addr_list {
> -	struct list_head list;
>  	int              count;
> +	u64              mc[0];

Please use the standard C99 syntax here:

	u64              mc[];

> +				mc_list = kmalloc(sizeof(*mc_list) +
> +						  sizeof(u64) * netdev_mc_count(netdev),
> +						  GFP_ATOMIC);

kmalloc_array(), please.
