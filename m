From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 11 Sep 2012 10:48:53 +0200
Subject: GCC 4.6.x miscompiling arm-linux?
In-Reply-To: <20120911092753.7b8315d4@archvile>
References: <20120910171654.1d4972b2@archvile>
 <w51bohddcqw.fsf@mail.mattleach.net>
 <20120911092753.7b8315d4@archvile>
Message-ID: <20120911084853.GT24458@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 09:27:53AM +0200, David Jander wrote:
> 
> Hi Matt,
> 
> >         @ Function supports interworking.
> >         @ args = 0, pretend = 0, frame = 0
> >         @ frame_needed = 0, uses_anonymous_args = 0
> >         @ link register save eliminated.
> >         cmp     r0, #9
> >         mov     r3, #0
> >         str     r3, [r1, #0]
> >         mov     r0, #0
> >         strgt   r3, [r1, #4]
> >         bx      lr
> >         .size   flexcan_chip_start, .-flexcan_chip_start
> >         .ident  "GCC: (GNU) 4.3.3"
> >         .section        .note.GNU-stack,"",%progbits
> > 
> > I think this looks correct. Perhaps you could try the angstrom arm5te
> > toolchain and see if it's a toolchain issue?
> 
> Yes, this looks a lot better, and is exactly what I get when I compile this
> code with CodeSourcery GCC-4.4.1
> 
> I have tries building gcc-4.6.3 also with OSELAS/PTXdist, and it gives the
> same (wrong) result as with gcc-4.6.2

AFAIK our OSELAS/PTXdist Toolchains use Linaro patches, this would
explain why both have the same result.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
