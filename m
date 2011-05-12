From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 12 May 2011 09:00:14 +0200
Subject: [PATCH 0/4] Pinmux subsystem
In-Reply-To: <BANLkTikTVEAWEjWV8da0Vq1vvOUDHa4FVw@mail.gmail.com>
References: <1304363768-30338-1-git-send-email-linus.walleij@stericsson.com>
	<20110503172712.GE6538@lunn.ch>
	<BANLkTi=ncV3M1q5SXNdUaXmtfkZ8Wn9dmw@mail.gmail.com>
	<20110511095031.GD31070@lunn.ch>
	<BANLkTikTVEAWEjWV8da0Vq1vvOUDHa4FVw@mail.gmail.com>
Message-ID: <20110512070014.GE31070@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > To me, it makes more sense that drivers/pinmux/kirkwood.c provides the
> > unique pin functions, where there are no alternatives, eg the twi
> > 0. It could also provide the pin functions used my Marvell in the
> > kirkwood reference design. It is likely that many real boards will be
> > based on that. However, if my bubba3 SPI pins don't fit with the
> > Marvell RDK, i probably want to put them in my board file.
> 
> Sorry I'm not following, what is an RDK?

Reference Design Kit. 

A chip manufacture generally has a reference board which uses most of
the functionality of the chip. They generally make the board design
available, so that anybody wanting to design a new board around the
chip can start with the RDK and add/remove parts and customize it to
there own requirements. 

Marvell are a bit closed about there RDKs, so i picked an AT91 as an
example:

http://www.atmel.com/dyn/products/tools_card.asp?tool_id=4281&category_id=163&family_id=605&subfamily_id=1964

All the design files are there for download.

Many boards using an AT91SAM9XE will be similar to this. So if the
pinmux driver supports this board, it will be a good basis for all
other boards which use the AT91SAM9XE.

    Andrew
