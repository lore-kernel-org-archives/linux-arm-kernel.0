From: davem@davemloft.net (David Miller)
Date: Sat, 07 Mar 2015 22:30:20 -0500 (EST)
Subject: [PATCH v4 0/4] net/macb: merge at91_ether driver into macb driver
In-Reply-To: <1425709412-4935-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1425709412-4935-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150307.223020.1400708446360935463.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Sat,  7 Mar 2015 07:23:28 +0100

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
> 
> Patch 1 is fixing a problem that might happen when enabling ARM
> multi-platform suppot.

Series applied, thanks.
