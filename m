From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 30 Dec 2013 19:52:40 +0100
Subject: Can't boot newer kernel on Armada 370 dev board
In-Reply-To: <20131230183908.GB4172@enneenne.com>
References: <20131230174738.GA4172@enneenne.com>
 <20131230181205.GA32362@lunn.ch>
 <20131230183908.GB4172@enneenne.com>
Message-ID: <20131230185240.GA32537@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 30, 2013 at 07:39:08PM +0100, Rodolfo Giometti wrote:
> On Mon, Dec 30, 2013 at 07:12:05PM +0100, Andrew Lunn wrote:
> >
> > Hi Redolfo
> > 
> > What version of u-boot do you have?
> 
> U-Boot 2011.12 (Dec 24 2013 - 16:16:38) Marvell version: v2011.12 2013_Q3.0
> 
> > There has been a change in u-boot
> > so that the registers are mapped to a different address. Old u-boot
> > with new kernel causes instant lockup on boot as soon as it tries to
> > access the wrong address space.
> 
> I see. Where can I get newer u-boot releases in order to avoid this
> problem? :-)

>From Marvell.

It is also possible to modify the DT to use the old address. I think
there is a thread somewhere with Thomas Petazzoni telling somebody
what changes need to be made for Armada XP. 370 should be very
similar.

Basically you need to change 0xF1000000 to 0xD0000000.

	  Andrew
