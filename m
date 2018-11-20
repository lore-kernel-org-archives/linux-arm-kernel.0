From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 20 Nov 2018 11:55:57 +0100
Subject: [PATCH v4 03/26] clk: sunxi-ng: Add check for maximum rate to
 NKM PLLs
In-Reply-To: <CAMty3ZBTaeMBFYwyJ+8HqHBDAfEOPEYBt01jho1H4c3SBKbvEw@mail.gmail.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-4-jagan@amarulasolutions.com>
 <20181113132658.niwy6bqdqzaeqpv2@flea>
 <CAMty3ZBTaeMBFYwyJ+8HqHBDAfEOPEYBt01jho1H4c3SBKbvEw@mail.gmail.com>
Message-ID: <20181120105557.3mysirc3ga2h2334@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 08:51:04PM +0530, Jagan Teki wrote:
> > >  drivers/clk/sunxi-ng/ccu_nkm.c | 3 +++
> > >  drivers/clk/sunxi-ng/ccu_nkm.h | 1 +
> > >  2 files changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> > > index 6b5ad990f802..b8b66cdd30bf 100644
> > > --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> > > +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> > > @@ -128,6 +128,9 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
> > >       if (rate < nkm->min_rate)
> > >               return nkm->min_rate;
> > >
> > > +     if (nkm->max_rate && rate > nkm->max_rate)
> > > +             return nkm->max_rate;
> > > +
> >
> > I would expect the test to be the same for the minimum and maximum cases.
> 
> I don't have proper use-case for max rate test, I do verify by using
> higher the rate on dclock, but nor sure.  May be I can skip the
> max_rate patch?

So you're sending more patches that you haven't really tested?
Why are you sending them then?

> Apart from this, any idea about this issue where SUN4I_TCON0_DCLK_REG
> will only work with div upto 6 on A64 DSI panels[1], did you find the
> same issue on A33?

IIRC my panel was falling into the case where the divider was 4, so
I've not fallen into that case.

> With parent rate 330MHz, the resulting tcon divider for 30MHz [2]
> clock is 11 and for the same for 55MHz [3] clock is 6.

I'm not sure what the question is?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181120/3158d02c/attachment-0001.sig>
