From: davem@davemloft.net (David Miller)
Date: Tue, 18 Feb 2014 18:07:30 -0500 (EST)
Subject: [PATCH] NET: fec: only enable napi if we are successful
In-Reply-To: <E1WFkD8-0004pj-Pr@rmk-PC.arm.linux.org.uk>
References: <E1WFkD8-0004pj-Pr@rmk-PC.arm.linux.org.uk>
Message-ID: <20140218.180730.54681622364091114.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@arm.linux.org.uk>
Date: Tue, 18 Feb 2014 12:55:42 +0000

> If napi is left enabled after a failed attempt to bring the interface
> up, we BUG:
> 
> fec 2188000.ethernet eth0: no PHY, assuming direct connection to switch
> libphy: PHY fixed-0:00 not found
> fec 2188000.ethernet eth0: could not attach to PHY
> ------------[ cut here ]------------
> kernel BUG at include/linux/netdevice.h:502!
> Internal error: Oops - BUG: 0 [#1] SMP ARM
> ...
> PC is at fec_enet_open+0x4d0/0x500
> LR is at __dev_open+0xa4/0xfc
> 
> Only enable napi after we are past all the failure paths.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Applied, thanks a lot Russell.
