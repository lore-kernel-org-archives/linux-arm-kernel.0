From: davem@davemloft.net (David Miller)
Date: Sun, 05 Oct 2014 21:15:52 -0400 (EDT)
Subject: [PATCH 0/2] net: spider_net: fix possible bitops errors
In-Reply-To: <1412348517-20352-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1412348517-20352-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20141005.211552.452619735296906900.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>
Date: Fri,  3 Oct 2014 17:01:53 +0200

> Dan reported a possible signedness issue on the pxa168_eth driver. While
> having a look at it, I came across a similar problem in the spider_net
> driver.
> 
> Here is one proposal to fix it. The first patch rework the
> spider_net_set_mac() function by removing the spider_net_get_mac_address()
> call and using memcpy() to set netdev->dev_addr (which is what's done in
> lots of Ethernet drivers) and the second one fix the actual signedness
> issue.
> 
> If for any reason you really want to keep a call to
> spider_net_get_mac_address() because the memcpy() is somehow not good
> enough here, we can also come up with a solution involving a temporary
> unsigned char variable.

Series applied, thanks.
