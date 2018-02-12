From: davem@davemloft.net (David Miller)
Date: Sun, 11 Feb 2018 22:37:51 -0500 (EST)
Subject: [PATCH] mvpp2: fix multicast address filter
In-Reply-To: <alpine.LRH.2.02.1802111806550.12159@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1802111806550.12159@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <20180211.223751.2130845243634593943.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 11 Feb 2018 18:10:28 -0500 (EST)

> IPv6 doesn't work on the MacchiatoBIN board. It is caused by broken
> multicast address filter in the mvpp2 driver.
> 
> The driver loads doesn't load any multicast entries if "allmulti" is not
> set. This condition should be reversed.
> 
> The condition !netdev_mc_empty(dev) is useless (because
> netdev_for_each_mc_addr is nop if the list is empty).
> 
> This patch also fixes a possible overflow of the multicast list - if
> mvpp2_prs_mac_da_accept fails, we set the allmulti flag and retry.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Applied, thanks.
