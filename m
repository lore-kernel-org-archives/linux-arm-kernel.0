From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 Sep 2009 14:33:29 +0100
Subject: [PATCH 09/10] S3C64XX I2S: Set parent links for clock audio-bus.
In-Reply-To: <1b68c6790909150557q53bf9843g38bf41fcaf5beca3@mail.gmail.com>
References: <1253008961-10698-1-git-send-email-jassi.brar@samsung.com>
	<20090915111204.GJ22878@rakim.wolfsonmicro.main>
	<1b68c6790909150442m5aaf826fy73a9c48bd2fabbf2@mail.gmail.com>
	<20090915121539.GO22878@rakim.wolfsonmicro.main>
	<1b68c6790909150557q53bf9843g38bf41fcaf5beca3@mail.gmail.com>
Message-ID: <20090915133329.GT22878@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 09:57:05PM +0900, jassi brar wrote:
> On Tue, Sep 15, 2009 at 9:15 PM, Mark Brown

> > Are you sure? ?UART, USB, MMC and SPI all have options to clock off EPLL
> > - I've worked with designs that were actively using it for at least USB.

> In mainline?
> All these devices do have option to source from EPLL but they don't
> seem to use it.

I'd hope that given the active efforts that Samsung are making to push
things into mainline anything that isn't in mainline will be there
sooner rather than later.  Given that it seems better to avoid things
like this which will create issues after merge to mainline without
consideration for how things are supposed to work after the merge.

> > trying to play about with this simultaneously then what'll happen is
> > that users who end up trying to use those drivers together will have to
> > deal with the fallout.

> as i said in another reply, current set of patches are meant to be as
> simple as possible.
> once that is done I am all to implement and support new features.

Something with this much of a system wide effect really isn't a good
idea - the wider the effect of what you're doing the worse the effect of
any breakage that is introduced.
