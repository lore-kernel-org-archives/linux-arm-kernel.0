From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Mon, 19 Mar 2018 14:13:43 +0100
Subject: [EXT] Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR
 interface to use in-band negotiation
In-Reply-To: <20180319130823.GA22306@lunn.ch>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk>
 <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk>
 <20180319125227.GI4519@kwain> <20180319125953.GD19795@lunn.ch>
 <54e290a192734831b5db22191f056a81@IL-EXCH01.marvell.com>
 <20180319130823.GA22306@lunn.ch>
Message-ID: <20180319131343.GK4519@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 02:08:23PM +0100, Andrew Lunn wrote:
> > > If they don't have PHYs, how are the connected to the outside world?
> > 
> > By external SFP or direct attached cable.
> 
> Maybe i'm missing something, but don't you just need to add an SFP
> device in the device tree. The SFP code and PHYLINK will work
> together, query what the SFP module is, use the GPIOs to determine
> link up/down and module present, and tell the MAC how to configure the
> MAC-SFP link?

This would definitively work for SFP connectors with a PHY, but would
that work when using direct attached cable? As in the second case
phylink wouldn't be able to ask the SFP PHY for the link state.

Antoine

-- 
Antoine T?nart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
