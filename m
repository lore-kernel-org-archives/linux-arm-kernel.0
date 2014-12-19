From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 Dec 2014 18:35:49 +0100
Subject: [PATCH v2 1/4] clk: sunxi: Rework MMC phase clocks
In-Reply-To: <CAGb2v64J2Gp1gUh4AKH-1tjg94AcAarFZ5tJc_pr6FC71pJ6Rw@mail.gmail.com>
References: <1418765936-12542-1-git-send-email-maxime.ripard@free-electrons.com>
 <1418765936-12542-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64J2Gp1gUh4AKH-1tjg94AcAarFZ5tJc_pr6FC71pJ6Rw@mail.gmail.com>
Message-ID: <20141219173549.GL4820@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 02:58:33PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Wed, Dec 17, 2014 at 5:38 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Instead of having three different clocks for the main MMC clock and the two
> > phase sub-clocks, which involved having three different drivers sharing the
> > same register, rework it to have the same single driver registering three
> > different clocks.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  Documentation/devicetree/bindings/clock/sunxi.txt |   7 +-
> >  drivers/clk/sunxi/clk-mod0.c                      | 131 ++++++++++++----------
> >  2 files changed, 74 insertions(+), 64 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> > index 9dc4f55a04ad..8c60433a7fc9 100644
> > --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> > +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> > @@ -55,8 +55,7 @@ Required properties:
> >         "allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
> >         "allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
> >         "allwinner,sun5i-a13-mbus-clk" - for the MBUS clock on A13
> > -       "allwinner,sun4i-a10-mmc-output-clk" - for the MMC output clock on A10
> > -       "allwinner,sun4i-a10-mmc-sample-clk" - for the MMC sample clock on A10
> > +       "allwinner,sun4i-a10-mmc-clk" - for the MMC clock
> >         "allwinner,sun4i-a10-mod0-clk" - for the module 0 family of clocks
> >         "allwinner,sun8i-a23-mbus-clk" - for the MBUS clock on A23
> >         "allwinner,sun7i-a20-out-clk" - for the external output clocks
> > @@ -95,6 +94,10 @@ For "allwinner,sun6i-a31-pll6-clk", there are 2 outputs. The first output
> >  is the normal PLL6 output, or "pll6". The second output is rate doubled
> >  PLL6, or "pll6x2".
> >
> > +The "allwinner,sun4i-a10-mmc-clk" has three different outputs: the
> > +main clock, with the ID 0, and the output and sample clocks, with the
> > +IDs 1 and 2, respectively.
> > +
> 
> Could you also update the mmc/mod0 clock example in the bindings?
> Currently it is an mmc module clock using the mod0 compatible.

I'll do that, yep.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141219/1aafcd8d/attachment.sig>
