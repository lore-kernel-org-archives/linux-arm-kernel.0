From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 23 Aug 2017 18:04:44 +0200
Subject: [EXT] Re: [PATCH net-next 10/18] net: mvpp2: use the GoP
 interrupt for link status changes
In-Reply-To: <5ebd192c54984b25adda0a294035b1b9@IL-EXCH01.marvell.com>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-11-antoine.tenart@free-electrons.com>
 <20170726162648.GK12049@lunn.ch> <20170823082510.GD5202@kwain>
 <5ebd192c54984b25adda0a294035b1b9@IL-EXCH01.marvell.com>
Message-ID: <20170823160444.GC23960@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 23, 2017 at 03:24:55PM +0000, Stefan Chulski wrote:
> > When the cable is connected (there is signal) and the serdes is in sync and AN
> > succeeded.
> > 
> > > With SFF/SFP ports, you generally need a gpio line the fibre module
> > > can use to indicate if it has link. Fixed-phy has such support, and
> > > your link_change function will get called when the link changes.
> > 
> > So that would work when using SFP modules but I wonder if the GoP irq isn't
> > needed when using passive cable, in which case this patch would still be needed
> > (and of course we should support the new Russell phylib capabilities).
> 
> Even if new phylib driver supports passive direct cables connection, 
> GoP IRQ required for SOHO/Peridot external switch support.
> SOHO/Peridot external switch could be connected directly to Serdes line.

So I guess the GoP link irq patches are needed. Should I resend them
then?

We'll have to discuss how to handle fixed-phy vs GoP IRQ, but I guess we
can do this when adding the fixed-phy support later.

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170823/f8f2ffb0/attachment.sig>
