From: horms@verge.net.au (Simon Horman)
Date: Fri, 10 Nov 2017 11:55:08 +0100
Subject: [PATCH v4 02/15] arm64: dts: renesas: r8a7795-es1: Add IPMMU
 device nodes
In-Reply-To: <CAMuHMdUgW=KNLAg-hEoOPCF0-q=iP+j_PLFb4Qfxt+HSobZgnA@mail.gmail.com>
References: <20171101103452.7491-1-horms+renesas@verge.net.au>
 <20171101103452.7491-3-horms+renesas@verge.net.au>
 <CAMuHMdUgW=KNLAg-hEoOPCF0-q=iP+j_PLFb4Qfxt+HSobZgnA@mail.gmail.com>
Message-ID: <20171110105507.gio5hrbcp5msn6z5@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 07, 2017 at 10:11:20AM +0100, Geert Uytterhoeven wrote:
> On Wed, Nov 1, 2017 at 11:34 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > From: Magnus Damm <damm+renesas@opensource.se>
> >
> > Add r8a7795 ES1.x IPMMU nodes and keep all disabled by default.
> >
> > This is a follow-up to a patch that adds IPMMU device nodes that
> > are common to r8a7795 ES1.x and ES2.0
> >
> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > --- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
> > @@ -26,6 +26,22 @@
> >         /delete-node/ mmu at fd960000;
> >         /delete-node/ mmu at fd970000;
> >
> > +       ipmmu_mp1: mmu at ec680000 {
> > +               compatible = "renesas,ipmmu-r8a7795";
> > +               reg = <0 0xec680000 0 0x1000>; /* IPMMU-MP1 */
> 
> Do we need the comments?

Now that you mention it I don't think so. I will remove them.
