From: ramesh.shanmugasundaram@bp.renesas.com (Ramesh Shanmugasundaram)
Date: Mon, 29 Feb 2016 11:06:34 +0000
Subject: [PATCH 1/2] can: rcar_can: Add r8a7795 support
In-Reply-To: <CAMuHMdV3EsvN=sqiB2npB=cH8Bz4D6UVcQj-BKqfdHerKSDowQ@mail.gmail.com>
References: <1456737661-20538-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1456737661-20538-2-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <CAMuHMdV3EsvN=sqiB2npB=cH8Bz4D6UVcQj-BKqfdHerKSDowQ@mail.gmail.com>
Message-ID: <SG2PR06MB10389D8C1D30451EC2AE8FF0C3BA0@SG2PR06MB1038.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

> On Mon, Feb 29, 2016 at 10:21 AM, Ramesh Shanmugasundaram
> <ramesh.shanmugasundaram@bp.renesas.com> wrote:
> > --- a/drivers/net/can/rcar_can.c
> > +++ b/drivers/net/can/rcar_can.c
> > @@ -808,6 +808,10 @@ static int rcar_can_probe(struct platform_device
> *pdev)
> >         priv->regs = addr;
> >         priv->clock_select = clock_select;
> >         priv->can.clock.freq = clk_get_rate(priv->can_clk);
> > +
> > +       /* Use the rounded clock value (nearest kHz) */
> > +       priv->can.clock.freq = 1000 *
> > + DIV_ROUND_UP(priv->can.clock.freq, 1000);
> 
> The comment and the implementation don't match.
> To get the nearest kHz, you have to useDIV_ROUND_CLOSEST().

Thanks Geert. Yes, DIV_ROUND_CLOSEST() would be apt as you pointed out.
I'll be removing this hack when I rebase, as Marc is fixing the algorithm.

Thanks,
Ramesh
