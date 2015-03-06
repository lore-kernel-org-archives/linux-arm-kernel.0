From: davem@davemloft.net (David Miller)
Date: Fri, 06 Mar 2015 15:16:53 -0500 (EST)
Subject: [PATCH v2 0/2] net/macb: merge at91_ether driver into macb driver
In-Reply-To: <1425622439-2372-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1425622439-2372-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150306.151653.2133726487330517804.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Fri,  6 Mar 2015 07:13:57 +0100

> The rm9200 boards use the dedicated at91_ether driver instead of the
> regular macb driver.
> 
> Both the macb and at91_ether drivers can be compiled as separated
> modules.
> Since the at91_ether driver uses code from the macb driver, at91_ether.ko
> depends on macb.ko.
> 
> However the macb.ko module always fails to load on rm9200 boards: the
> macb_probe() function expects a hclk clock which doesn't exist on rm9200.
> Then the at91_ether.ko can't be loaded in turn due to unresolved
> dependencies.
> 
> This series of patches fix this issue by merging at91_ether into macb.

Series applied to net-next, thanks.
