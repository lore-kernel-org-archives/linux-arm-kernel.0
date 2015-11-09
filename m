From: horms@verge.net.au (Simon Horman)
Date: Mon, 9 Nov 2015 11:19:31 +0900
Subject: [PATCH v11 6/8] arm64: renesas: add Salvator-X board support on
 DTS
In-Reply-To: <CAMuHMdX=LS2sLqtgBUYeWjVkUVZE2WQwsWhbvK+wmdfZ0ycrjg@mail.gmail.com>
References: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
 <1444890243-6978-7-git-send-email-horms+renesas@verge.net.au>
 <20151015110139.GG8825@leverpostej>
 <20151023070032.GA4502@verge.net.au>
 <CAMuHMdVzUPyhkfPy3s+jBK1gQ-kZqYfrQZ8Bww-iFxGOPVZn2w@mail.gmail.com>
 <CAMuHMdX=LS2sLqtgBUYeWjVkUVZE2WQwsWhbvK+wmdfZ0ycrjg@mail.gmail.com>
Message-ID: <20151109021928.GB30553@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 03, 2015 at 03:24:06PM +0100, Geert Uytterhoeven wrote:
> Hi Mark, Rob,
> 
> On Thu, Oct 29, 2015 at 8:52 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Fri, Oct 23, 2015 at 9:00 AM, Simon Horman <horms@verge.net.au> wrote:
> >> On Thu, Oct 15, 2015 at 12:01:40PM +0100, Mark Rutland wrote:
> >>> > +           stdout-path = &scif2;
> >>>
> >>> No rate? It would be better to be explicit here; you should be able to
> >>> have:
> >>>
> >>>       stdout-path = "serial0:115200n8"
> >>>
> >>> Where "115200n8" is replaced with whatever configuration this board
> >>> actually has.
> >>
> >> I think that we have had this discussion before in relation to
> >> a different board for a different Renesas SoC but I could be mistaken.
> >
> > IIRC, at that time the code to parse the options wasn't upstream yet, so
> > adding the options would have broken the serial console.
> >
> > I can confirm it works fine on Salvator-X with
> >
> >         stdout-path = "serial0:115200n8";
> 
> Unfortunately this breaks earlycon support:
> 
>         Malformed early option 'earlycon'
> 
> The call to fdt_getprop() in early_init_dt_scan_chosen_serial() fails.
> I guess that unlike the standard console handling code, the fdt code can't
> handle aliases yet?
> 
> P.S. SCIF earlycon support is not yet upstream, as it still doesn't work on
> arm32 (I discovered today it does on arm64 ;-): it pretends to work, but
> nothing is output to the serial port (until the normal serial console kicks
> in).

As discussed off-list.

I will update the stdout-path as Mark suggested.
The expectation being that early con will support that syntax.
