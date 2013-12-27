From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 27 Dec 2013 12:55:10 -0500
Subject: [PATCH RFCv1 0/6] ARM: mvebu: coherency support improvements
In-Reply-To: <20131226162931.GD19323@lunn.ch>
References: <1388067146-18111-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20131226160831.GB19323@lunn.ch> <20131226171302.3409b096@skate>
 <20131226162931.GD19323@lunn.ch>
Message-ID: <20131227175510.GW19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

resending to include the MLs

On Thu, Dec 26, 2013 at 05:29:31PM +0100, Andrew Lunn wrote:
> On Thu, Dec 26, 2013 at 05:13:02PM +0100, Thomas Petazzoni wrote:
> > Dear Andrew Lunn,
> > 
> > On Thu, 26 Dec 2013 17:08:31 +0100, Andrew Lunn wrote:
> > 
> > > In the .dtsi file i would suggest multiple compatibilities from the
> > > most specific to the most general. So listing:
> > > marvell,armada-370-coherency-fabric,
> > > marvell,armada-370-xp-coherency-fabric,
> > > 
> > > gives you the most forward/backward compatibility, as you discover
> > > more about the hardware.
> > 
> > True, that's another possibility. Though it's unclear if a compatible
> > string such as "marvell,armada-370-xp-coherency-fabric" makes sense. If
> > you create such a compatible string, and then later discover than 370
> > and XP cannot be handled in a same way, then why have a "shared"
> > compatible string?
> 
> Well presumably, if you need to split it further, it is somehow
> broken, or at least not optimal. Anybody who cannot update there DT
> blob keeps with the current somehow broken/non-optimal behavior, but
> those who can upgrade there DT blob get better behavior.
> 
> More compatible strings helps with backward compatibility for old DT
> blobs.

Please, let's not over-think this.  Right now, are there _any_
capability differences we're aware of between the two?  If not, then we
should use marvell,armada-370-xp-coherency-fabric.  *after* we discover
an incompatible difference, then we add
marvell,armada-370-coherency-fabric.  The driver, if it sees the new
compatible string, will use the new feature.  If it doesn't, it will
default to the old behavior as it was under
marvell,armada-370-xp-coherency-fabric.

Let's not get ahead of ourselves guessing towards the 'perfect' DT
binding.

thx,

Jason.
