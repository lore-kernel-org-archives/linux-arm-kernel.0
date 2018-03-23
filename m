From: horms@verge.net.au (Simon Horman)
Date: Fri, 23 Mar 2018 10:05:00 +0100
Subject: [PATCH v2 2/4] arm64: dts: renesas: r8a7795: sort subnodes of
 the soc node
In-Reply-To: <CAMuHMdWz9wr0iVVqJ=abm1LRZ3QcfWTk02bKk-MpkVP=mBX52w@mail.gmail.com>
References: <20180322102423.18269-1-horms+renesas@verge.net.au>
 <20180322102423.18269-3-horms+renesas@verge.net.au>
 <CAMuHMdWz9wr0iVVqJ=abm1LRZ3QcfWTk02bKk-MpkVP=mBX52w@mail.gmail.com>
Message-ID: <20180323090459.xmzcihmln6bxynzk@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2018 at 09:41:29AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Mar 22, 2018 at 11:24 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Sort subnodes of the soc node.
> > - The primary key is the bus address.
> > - The secondary key is the IP block.
> > - The tertiary key is the node name.
> >
> > This is part of an ongoing effort to provide consistent node
> > order in the DT of Renesas SoCs to improve maintainability.
> >
> > This should not have any run-time effect.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > v2
> > * Rebase
> 
> Thanks for the update!
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> using dtx_diff, and "grep '@.*{', which tells me
> 
> > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> 
> >                 pciec0: pcie at fe000000 {
> > @@ -2097,6 +2090,23 @@
> >                         status = "disabled";
> >                 };
> >
> > +               gic: interrupt-controller at f1010000 {
> 
> Probably gic should be before pciec0.
> Currently it's after pciec1, which has a lower address than pciec1.

Thanks, I will fix this in v3.
