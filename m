From: horms@verge.net.au (Simon Horman)
Date: Fri, 30 Oct 2015 16:51:53 +0900
Subject: [PATCH v11 6/8] arm64: renesas: add Salvator-X board support on
 DTS
In-Reply-To: <CAMuHMdVzUPyhkfPy3s+jBK1gQ-kZqYfrQZ8Bww-iFxGOPVZn2w@mail.gmail.com>
References: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
 <1444890243-6978-7-git-send-email-horms+renesas@verge.net.au>
 <20151015110139.GG8825@leverpostej>
 <20151023070032.GA4502@verge.net.au>
 <CAMuHMdVzUPyhkfPy3s+jBK1gQ-kZqYfrQZ8Bww-iFxGOPVZn2w@mail.gmail.com>
Message-ID: <20151030075152.GE31252@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 08:52:12AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Oct 23, 2015 at 9:00 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Oct 15, 2015 at 12:01:40PM +0100, Mark Rutland wrote:
> >> > +           stdout-path = &scif2;
> >>
> >> No rate? It would be better to be explicit here; you should be able to
> >> have:
> >>
> >>       stdout-path = "serial0:115200n8"
> >>
> >> Where "115200n8" is replaced with whatever configuration this board
> >> actually has.
> >
> > I think that we have had this discussion before in relation to
> > a different board for a different Renesas SoC but I could be mistaken.
> 
> IIRC, at that time the code to parse the options wasn't upstream yet, so
> adding the options would have broken the serial console.
> 
> I can confirm it works fine on Salvator-X with
> 
>         stdout-path = "serial0:115200n8";

Thanks.

Is this considered to be best practice?
If so I am of a mind to update the patch.

> > The r8a7795 uses the sh-sci serial driver for which the default rate is
> > 115200. It is hard for me to conceive of a situation where that would
> > change without due consideration being given to the implications for DT
> > files.
> >
> > Not specifying the baud here is consistent with what we have
> > been doing for ARM32 Renesas SoCs for some time.
> 
> FWIW, I have updated all ARM32 Renesas DTSes locally:
>   1. Use alias in and add serial options to stdout-path,
>   2. Drop superfluous console= from bootargs (shmobile-legacy is gone,
>      and it works fine on boards with both fbdev and serial consoles).
> 
> And everything looks fine on the boards I could try it on (sh73a0/kzm9g,
> r8a73a4/ape6evm, r8a7740/armadillo, r8a7791/koelsch).
> 
> Hence if you're open for this change, I can submit patches (or a single patch,
> up to your preference).

Sure, I'm happy to consider that (I slightly prefer per-board patches) if:

* That is now considered best practice and;
* Due consideration is given to backwards compatibility
  (I suspect it is new DTs work with old kernels so its a non-issue)
