From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 19 Nov 2013 09:14:55 +0100
Subject: [PATCH 0/4] Socfpga: clk: trivial fixes and cleanup
In-Reply-To: <CADhT+wffgF1veA8ec4zF7J3_4tsKUZXcq5-X9cLCgN5D3A7Nrw@mail.gmail.com>
References: <1383836828-24886-1-git-send-email-s.trumtrar@pengutronix.de>
 <1384215177.17054.2.camel@linux-builds1>
 <5281A332.6060300@gmail.com>
 <20131112074028.GW28790@pengutronix.de>
 <CADhT+wffgF1veA8ec4zF7J3_4tsKUZXcq5-X9cLCgN5D3A7Nrw@mail.gmail.com>
Message-ID: <20131119081455.GD7443@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh!

On Mon, Nov 18, 2013 at 11:11:52AM -0600, Dinh Nguyen wrote:
> Hi Steffen,
> 
> 
> On Tue, Nov 12, 2013 at 1:40 AM, Steffen Trumtrar <s.trumtrar@pengutronix.de
> > wrote:
> > I actually also wanted to change the l3_sp_clk, as it seems to be neglect
> > the "1 or 2" divider from l3_mp_clk IIRC, but I couldn't come up with a
> > good
> > way without changing the binding or something. What do you thing about
> > that?
> > Is that wrong at the moment or do I miss something?
> >
> 
> Ah yes, the l3_sp_clk's parent should be l3_mp_clk and not mainclk.
> 
> Thanks for spotting that...
> 
> Dinh
> 

Hm, that doesn't sound right. Don't we currently have Gate+Divider combo in
the l3_mp_clk? If you turn off the clock gate from the l3_mp_clk, then l3_sp_clk
would also be turned off.
But according to Figure 2-3 in cv_5v4.pdf

	DIV1 --------> GATE -----> L3_MP_CLK
                 |
		 |---- DIV2 -----> L3_SP_CLK

So, l3_sp_clk's parent is the divider of l3_mp_clk but NOT the gate.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
