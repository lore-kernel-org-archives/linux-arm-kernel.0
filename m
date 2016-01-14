From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jan 2016 13:08:18 +0100
Subject: [PATCH] mtd: nuc900_nand: read correct SMISR register
In-Reply-To: <56976BA9.2040709@iommu.org>
References: <9019174.GYajdpGP8V@wuerfel> <20160114002900.GA54220@google.com>
 <56976BA9.2040709@iommu.org>
Message-ID: <4251392.DUmfQyrPag@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 January 2016 17:34:33 Wan Zongshun wrote:
> -------- Original Message --------
> > On Wed, Jan 13, 2016 at 11:02:06PM +0100, Arnd Bergmann wrote:
> >> On Wednesday 13 January 2016 13:50:13 Brian Norris wrote:
> >>>
> >>> Looks OK to me, though I kinda hate dragging on support for
> >>> obviously-unused drivers...
> >>
> >> Should we mark that driver in Kconfig as obviously broken then?
> >
> > Well, it won't be obviously broken if I apply your patch... But if
> > that's the right step toward removal, then I could be OK with that.
> >
> >> Let's wait for Wan ZongShun to reply first, it's possible that the
> >> entire w90x900 platform has come to the point where we are better off
> >> removing it than fixing ancient bugs.
> >
> > Sounds good.
> 
> Actually, Nuvoton should still leverage this upstream w90x900 codes for 
> their old and new arm chip BSP, but I am not sure their open source plan 
> for the new chip now, I will check with Nuvoton for this topic, and give 
> you feedback here, so please hold on its removal.

Ok, sure. Thanks for the quick reply!

I've had a look around at the current produce lineup, and it seems that
nuc900 (w90x900) is still marketed, and as you say is similar to the n329
series.

There has been one attempt to do a modern port for n329 in 2014 but
it never got submitted. See http://comments.gmane.org/gmane.linux.kernel.kernelnewbies/49077
and https://github.com/mpthompson/linux/tree/n329

The code looks rather nice, so it's a pity that the effort stalled,
but it should not be hard for anyone to start out with Mike's tree
and forward-port it to 4.5.

	Arnd
