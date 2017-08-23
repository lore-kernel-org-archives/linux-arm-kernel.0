From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 23 Aug 2017 10:25:10 +0200
Subject: [PATCH net-next 10/18] net: mvpp2: use the GoP interrupt for
 link status changes
In-Reply-To: <20170726162648.GK12049@lunn.ch>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-11-antoine.tenart@free-electrons.com>
 <20170726162648.GK12049@lunn.ch>
Message-ID: <20170823082510.GD5202@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew, Russell,

On Wed, Jul 26, 2017 at 06:26:48PM +0200, Andrew Lunn wrote:
> On Mon, Jul 24, 2017 at 03:48:40PM +0200, Antoine Tenart wrote:
> > This patch adds the GoP link interrupt support for when a port isn't
> > connected to a PHY. Because of this the phylib callback is never called
> > and the link status management isn't done. This patch use the GoP link
> > interrupt in such cases to still have a minimal link management. Without
> > this patch ports not connected to a PHY cannot work.
> 
> When is a GoP link interrupt signalled? When is a port without a PHY
> actually up/down?

When the cable is connected (there is signal) and the serdes is in sync
and AN succeeded.

> With SFF/SFP ports, you generally need a gpio line the fibre module
> can use to indicate if it has link. Fixed-phy has such support, and
> your link_change function will get called when the link changes.

So that would work when using SFP modules but I wonder if the GoP irq
isn't needed when using passive cable, in which case this patch would
still be needed (and of course we should support the new Russell phylib
capabilities).

What's your thoughts on this?

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170823/dd2feb68/attachment.sig>
