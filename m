From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Wed, 30 Jan 2013 08:03:15 +0100
Subject: [BUG] i.MX25: soft lockups/freezes while getnstimeofday
In-Reply-To: <CAOMZO5DLDikzF5LMWQLw_65ADSy2-aydvhTbpFhbBV_DwS9sCQ@mail.gmail.com>
References: <20130129161230.GA3128@pengutronix.de>
 <CAOMZO5DLDikzF5LMWQLw_65ADSy2-aydvhTbpFhbBV_DwS9sCQ@mail.gmail.com>
Message-ID: <20130130070315.GC30136@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 02:38:59PM -0200, Fabio Estevam wrote:
> On Tue, Jan 29, 2013 at 2:12 PM, Steffen Trumtrar <s.trumtrar@pengutronix.de> wrote:
> > The board itself supposedly worked up until v3.4.
> >
> > The mxc-timer is set up to use ipg_clk_highfreq with a per5_div set to 2,
> > therefore it is clocked with 120MHz. I tried to set the per5_div to 4 to have
> > a 60MHz clock, but this didn't change anything.
> > On the other hand, I tried parenting the ipg_clk to the per5_clk to get a
> > 66MHz clock. This seems to be working fine, but I only have it running for 4h now.
>
> Can you dump the clock tree in 3.4 and 3.7.2, so that we can compare them?
>
> Just looked at the FSL BSP and they have the following:
>
> 	/* GPT clock must be derived from AHB clock */
> 	clk_set_rate(&per_clk[5], ahb_clk.rate / 10);

Do your hardware guys have documentation about *why* it "must be derived
from AHB clock"?

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
