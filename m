From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 22 Aug 2017 16:50:14 +0200
Subject: [PATCH net-next 03/18] net: mvpp2: set the SMI PHY address when
 connecting to the PHY
In-Reply-To: <20170822144101.GC14942@kwain>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-4-antoine.tenart@free-electrons.com>
 <20170726160806.GF12049@lunn.ch> <20170728014905.GC24728@kwain>
 <20170728042153.GH18666@lunn.ch> <20170822144101.GC14942@kwain>
Message-ID: <20170822145014.GB18076@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > It is still not clear to my why you need to program the address into
> > the hardware. Is the hardware talking to the PHY?
> 
> Sorry for the answer delay, I was out of the office...
> 
> This PHY address configuration should be done in the mvmdio driver as
> this is not directly related to the PPv2 (well, the mvmdio driver is
> only an abstraction to reuse the mdio code, using registers exposed by
> PPv2 in this case anyway). But two values must be known in order to do
> this: the PHY address and the GoP port number. Getting the last one from
> the mvmdio driver would be really ugly as we would need to read the PPv2
> dt node. This is why this patch adds it in the PPv2 driver, but I know
> it's not perfect.
> 
> I'll resend a series very soon, with this patch still included. We can
> continue the discussion there I guess, if needed.
> 
> Thanks!
Hi Antoine

You have still not explained why PPv2 needs to know the PHY address.

What i'm worried about is that the PPv2 is actually talking to the
PHY. Is it polling link state? Does it take the PHY mutex when it does
this poll?

     Andrew
