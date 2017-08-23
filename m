From: stefanc@marvell.com (Stefan Chulski)
Date: Wed, 23 Aug 2017 15:24:55 +0000
Subject: [EXT] Re: [PATCH net-next 10/18] net: mvpp2: use the GoP
 interrupt for link status changes
In-Reply-To: <20170823082510.GD5202@kwain>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-11-antoine.tenart@free-electrons.com>
 <20170726162648.GK12049@lunn.ch> <20170823082510.GD5202@kwain>
Message-ID: <5ebd192c54984b25adda0a294035b1b9@IL-EXCH01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> When the cable is connected (there is signal) and the serdes is in sync and AN
> succeeded.
> 
> > With SFF/SFP ports, you generally need a gpio line the fibre module
> > can use to indicate if it has link. Fixed-phy has such support, and
> > your link_change function will get called when the link changes.
> 
> So that would work when using SFP modules but I wonder if the GoP irq isn't
> needed when using passive cable, in which case this patch would still be needed
> (and of course we should support the new Russell phylib capabilities).
> 
> What's your thoughts on this?
> 
> Thanks!
> Antoine
> 

Even if new phylib driver supports passive direct cables connection, 
GoP IRQ required for SOHO/Peridot external switch support.
SOHO/Peridot external switch could be connected directly to Serdes line.

Regards,
Stefan
