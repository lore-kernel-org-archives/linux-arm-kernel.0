From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 14 Nov 2018 15:58:36 +0100
Subject: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
In-Reply-To: <20181114141632.GT30658@n2100.armlinux.org.uk>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
 <20181113234336.GP30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811141142490.8@nippy.intranet>
 <20181114141632.GT30658@n2100.armlinux.org.uk>
Message-ID: <CAMuHMdWwknYYEYpU4ogVAbpWtrF9aG=4vrh505dM2Btp8KjKMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Nov 14, 2018 at 3:16 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Nov 14, 2018 at 02:17:09PM +1100, Finn Thain wrote:
> > So, even assuming that you're right about the limitations of single-timer
> > platforms in general, removal of arch_gettimeoffset wouldn't require the
> > removal of any platforms, AFAICT.
>
> I haven't proposed removing platforms.
>
> I'm just objecting to the idea of removing arch_gettimeoffset(),
> thereby causing a regression by changing the resolution of
> gettimeofday() without any sign of equivalent functionality.
>
> However, I now see (having searched mailing lists) what you are
> trying to do - you have _not_ copied me or the mailing lists I'm
> on with your cover message, so I'm *totally* lacking in the context
> of your patch series, particularly where you are converting m68k
> to use clocksources without needing the gettimeoffset() stuff.
>
> You have failed to explain that in this thread - probably assuming
> that I've read your cover message.  I haven't until now, because
> you never sent it to me or the linux-arm-kernel mailing list.
>
> I have found this thread _very_ frustrating, and frankly a waste of
> my time discussing the finer points because of this lack of context.
> Please ensure that if you're going to be sending a patch series,
> that the cover message at least finds its way to the intended
> audience of your patches, so that everyone has the context they
> need when looking at (eg) the single patch they may receive.
>
> Alternatively, if someone raises a problem with the patch, and you
> _know_ you haven't done that, then please consider informing them
> where they can get more context, eg, by providing a link to your
> archived cover message.  It would help avoid misunderstandings.

Sorry for the lack of context.
The real trigger was also not explained in the cover message, and was a
the threat to remove platforms not using modern timekeeping APIs, cfr.
 "Removing support for old hardware from the kernel"
(https://lwn.net/Articles/769468/).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
