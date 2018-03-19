From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Mar 2018 14:08:23 +0100
Subject: [EXT] Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR
 interface to use in-band negotiation
In-Reply-To: <54e290a192734831b5db22191f056a81@IL-EXCH01.marvell.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk>
 <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk>
 <20180319125227.GI4519@kwain> <20180319125953.GD19795@lunn.ch>
 <54e290a192734831b5db22191f056a81@IL-EXCH01.marvell.com>
Message-ID: <20180319130823.GA22306@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > If they don't have PHYs, how are the connected to the outside world?
> > 
> >    Andrew
> 
> By external SFP or direct attached cable.

Maybe i'm missing something, but don't you just need to add an SFP
device in the device tree. The SFP code and PHYLINK will work
together, query what the SFP module is, use the GPIOs to determine
link up/down and module present, and tell the MAC how to configure the
MAC-SFP link?

     Andrew
