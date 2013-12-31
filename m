From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 31 Dec 2013 17:13:57 +0100
Subject: Can't boot newer kernel on Armada 370 dev board
In-Reply-To: <20131231103503.3bba7c08@skate>
References: <20131230174738.GA4172@enneenne.com>
 <20131230181205.GA32362@lunn.ch>
 <20131230183908.GB4172@enneenne.com>
 <20131230185240.GA32537@lunn.ch> <20131231103503.3bba7c08@skate>
Message-ID: <20131231161357.GC32537@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 31, 2013 at 10:35:03AM +0100, Thomas Petazzoni wrote:
> Andrew, Rodolfo,
> 
> On Mon, 30 Dec 2013 19:52:40 +0100, Andrew Lunn wrote:
> 
> > > U-Boot 2011.12 (Dec 24 2013 - 16:16:38) Marvell version: v2011.12 2013_Q3.0
> > > 
> > > > There has been a change in u-boot
> > > > so that the registers are mapped to a different address. Old u-boot
> > > > with new kernel causes instant lockup on boot as soon as it tries to
> > > > access the wrong address space.
> > > 
> > > I see. Where can I get newer u-boot releases in order to avoid this
> > > problem? :-)
> > 
> > From Marvell.
> > 
> > It is also possible to modify the DT to use the old address. I think
> > there is a thread somewhere with Thomas Petazzoni telling somebody
> > what changes need to be made for Armada XP. 370 should be very
> > similar.
> > 
> > Basically you need to change 0xF1000000 to 0xD0000000.
> 
> No, that's the opposite.
> 
> The mainline kernel uses 0xD0000000 for this board, because originally
> the Marvell Armada 370 DB was shipped with an old U-Boot, which was
> mapping registers at 0xD0000000.
> 
> Apparently, they are now shipping these boards with a more recent
> version of U-Boot that uses 0xF1000000. Therefore, Rodolfo should
> change the kernel from 0xD0000000 to 0xF1000000.

Ah, O.K. Good to know.

I think we need to better document this. For example put a comment in
the top of each .dts file about the issues and which u-boot version is
known to work, and which version needs an alternative .dts file.
Maybe also how you can tell from a running system, eg what to look for
in /proc/iomem.

   Andrew
