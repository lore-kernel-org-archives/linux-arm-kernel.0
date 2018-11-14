From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Nov 2018 18:11:35 +0000
Subject: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
In-Reply-To: <CAMuHMdWwknYYEYpU4ogVAbpWtrF9aG=4vrh505dM2Btp8KjKMg@mail.gmail.com>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
 <20181113234336.GP30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811141142490.8@nippy.intranet>
 <20181114141632.GT30658@n2100.armlinux.org.uk>
 <CAMuHMdWwknYYEYpU4ogVAbpWtrF9aG=4vrh505dM2Btp8KjKMg@mail.gmail.com>
Message-ID: <20181114181135.GU30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2018 at 03:58:36PM +0100, Geert Uytterhoeven wrote:
> Hi Russell,
> 
> On Wed, Nov 14, 2018 at 3:16 PM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Wed, Nov 14, 2018 at 02:17:09PM +1100, Finn Thain wrote:
> > > So, even assuming that you're right about the limitations of single-timer
> > > platforms in general, removal of arch_gettimeoffset wouldn't require the
> > > removal of any platforms, AFAICT.
> >
> > I haven't proposed removing platforms.
> >
> > I'm just objecting to the idea of removing arch_gettimeoffset(),
> > thereby causing a regression by changing the resolution of
> > gettimeofday() without any sign of equivalent functionality.
> >
> > However, I now see (having searched mailing lists) what you are
> > trying to do - you have _not_ copied me or the mailing lists I'm
> > on with your cover message, so I'm *totally* lacking in the context
> > of your patch series, particularly where you are converting m68k
> > to use clocksources without needing the gettimeoffset() stuff.
> >
> > You have failed to explain that in this thread - probably assuming
> > that I've read your cover message.  I haven't until now, because
> > you never sent it to me or the linux-arm-kernel mailing list.
> >
> > I have found this thread _very_ frustrating, and frankly a waste of
> > my time discussing the finer points because of this lack of context.
> > Please ensure that if you're going to be sending a patch series,
> > that the cover message at least finds its way to the intended
> > audience of your patches, so that everyone has the context they
> > need when looking at (eg) the single patch they may receive.
> >
> > Alternatively, if someone raises a problem with the patch, and you
> > _know_ you haven't done that, then please consider informing them
> > where they can get more context, eg, by providing a link to your
> > archived cover message.  It would help avoid misunderstandings.
> 
> Sorry for the lack of context.
> The real trigger was also not explained in the cover message, and was a
> the threat to remove platforms not using modern timekeeping APIs, cfr.
>  "Removing support for old hardware from the kernel"
> (https://lwn.net/Articles/769468/).

And naturally, because kernel developers are oh so great at
communication, that decision has been communicated to those
affected by it. *NOT*.

Clearly there is a need for much better communication.  We're
better at it when dealing with patches, but not when it comes to
physical meetings.

Maybe when some decision like "we're going to kill stuff still
using the old gettimeoffset API" then _someone_ needs to identify
which platforms are using that and make sure that those maintainers
know about that decision, much the same way that if a patch were
to touch the gettimeoffset API, we'd make damn sure that such a
patch went to those affected by the change.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
