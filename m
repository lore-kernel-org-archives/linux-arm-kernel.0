From: mikpe@it.uu.se (Mikael Pettersson)
Date: Mon, 28 Sep 2009 13:40:11 +0200
Subject: [PATCH 1/2] n2100: support assigning XINT1 to UART
In-Reply-To: <20090928100535.GE6715@n2100.arm.linux.org.uk>
References: <19134.28977.5491.323804@pilspetsen.it.uu.se>
	<20090928095813.GJ1773@mail.wantstofly.org>
	<20090928100535.GE6715@n2100.arm.linux.org.uk>
Message-ID: <19136.41115.286197.101467@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux writes:
 > On Mon, Sep 28, 2009 at 11:58:13AM +0200, Lennert Buytenhek wrote:
 > > Can't you detect whether the 8250 IRQ is routed at boot?  E.g. cause
 > > the UART to throw an interrupt, check the XINT, clear the interrupt,
 > > and check the XINT again, and see if the 8250 interrupt status
 > > corresponds to the XINT or not?  (And then printk the result of the
 > > detection.)
 > 
 > 8250 already has support for auto-probing its interrupt.

The question is how well things work if the 2nd uhci and
serial share (software) interrupt. I'll have to check.
