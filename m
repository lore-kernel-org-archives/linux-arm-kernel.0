From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 29 Oct 2013 21:37:51 +0800
Subject: [PATCH] ARM: imx: replace imx6q_restart() with mxc_restart()
In-Reply-To: <20131029113756.GP16735@n2100.arm.linux.org.uk>
References: <1381050370-3301-1-git-send-email-shawn.guo@linaro.org>
 <CAOesGMjB6D3owftDUfmMbVNx8_EtY9-RXoGbS3Rmry4FQhSfZQ@mail.gmail.com>
 <20131028081408.GF2839@S2101-09.ap.freescale.net>
 <CAOesGMijji0JBJqne_j8kPedYFF82U7fh7KS92PV1hJztJXE6w@mail.gmail.com>
 <20131029020603.GH2839@S2101-09.ap.freescale.net>
 <20131029095332.5d926e8b@ipc1.ka-ro>
 <20131029113756.GP16735@n2100.arm.linux.org.uk>
Message-ID: <20131029133744.GJ2839@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 11:37:56AM +0000, Russell King - ARM Linux wrote:
> On Tue, Oct 29, 2013 at 09:53:32AM +0100, Lothar Wa?mann wrote:
> > Hi,
> > 
> > Shawn Guo wrote:
> > > On Mon, Oct 28, 2013 at 10:46:02AM -0700, Olof Johansson wrote:
> > > > By the way, the errata document says that you must write it twice
> > > > within one 32kHz clock period. You might want to write it three times
> > > > just in case two of them happen to straddle that period by pure bad
> > > > luck. I'm guessing it's rare enough that you haven't been able to
> > > > reproduce it though.
> > > 
> > > With CPU running at hundred MHz, two writes in the row should not
> > > straddle one 32kHz clock period - 31.25 us.
> > > 
> > But they still may end up in adjacent periods of the 32MHz
> > clock. If both writes have to happen within the same period of the
> > clock, the third write may be necessary to guarantee this.
> 
> Yes, that is correct to the description given.  It's also rather vague
> in that it doesn't describe the mechanism for the bug, so we can't say
> for certain whether two or three writes are sufficient.
> 
> If the problem is to do with a write too close to the 32kHz clock edge,
> then two writes should solve it (if the first is too close, the second
> one will likely be afterwards).  If the problem is something else, then
> three writes would be sensible.
> 
> As we don't have this information, I'd suggest using three just to be
> sure as Lothar suggests.

Yea, it seems that I've missed Olof's point at the first place.  Thank
you and Lothar for clarification, and I will add a third write in the
follow-up patch, so that we can be safe for sure.

Shawn
