From: davem@davemloft.net (David Miller)
Date: Thu, 19 Jul 2018 08:13:00 +0900 (KST)
Subject: [PATCH 2/5] net: add an info message to
 eth_platform_get_mac_address()
In-Reply-To: <20180718161035.7005-3-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-3-brgl@bgdev.pl>
Message-ID: <20180719.081300.1581730029693790076.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 18 Jul 2018 18:10:32 +0200

>  
> +	dev_info(dev, "read MAC address from %s\n", from);
>  	ether_addr_copy(mac_addr, addr);
>  	return 0;

Ugh, please don't do this.

We probe various bits of information from various sources during
driver probe, and none of them are more or less important than
the MAC address.  So singling this out for log info output is
really not such a great idea.

Thank you.
