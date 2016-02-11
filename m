From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 11 Feb 2016 09:40:29 +0100
Subject: noise issues when recording sound on i.MX28
In-Reply-To: <CAOMZO5D5H4F90nse9kyW9KvsJStN-sCGktup4FDPw_zTeNfS2g@mail.gmail.com>
References: <20160127105613.GC13664@pengutronix.de>
 <CAOMZO5BpLen517q2heramSta-R6pdESkjM6w=7FRMZebY6ue-Q@mail.gmail.com>
 <20160127144340.GD13664@pengutronix.de>
 <CAOMZO5AE6HwBYz7kOFORt0HTojJLSb0MYUbkb_HCshDHy=d27g@mail.gmail.com>
 <20160210150315.GC13664@pengutronix.de>
 <CAOMZO5D5H4F90nse9kyW9KvsJStN-sCGktup4FDPw_zTeNfS2g@mail.gmail.com>
Message-ID: <20160211084029.GE13664@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 06:10:18PM -0200, Fabio Estevam wrote:
> Hi Uwe,
> 
> On Wed, Feb 10, 2016 at 1:03 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > Hello Fabio,
> >
> > On Tue, Feb 02, 2016 at 11:00:33AM -0200, Fabio Estevam wrote:
> >> On Wed, Jan 27, 2016 at 12:43 PM, Uwe Kleine-K?nig
> >> <u.kleine-koenig@pengutronix.de> wrote:
> >>
> >> > So you didn't hit the problem that resetting a saif didn't work, right?
> >>
> >> No, we haven't seen this reset issue.
> >>
> >> > Do you have a few more technical details here? A usecase of my machine
> >>
> >> Let me find out as it has been several years I worked on this problem.
> >> Will let you know.
> >
> > Anything new on your end? I know from Lothar that he invested quite some
> > time to debug his hardware setup, tested the codec instead of the i.MX28
> > as clock provider and several more things. I also spend some time on
> > this issue and we both hope that Freescale/NXP can help in better
> > understanding the issue and hopefully can come up with a recipe to make
> > concurrent recording and playback on i.MX28 work.
> >
> > Lothar is in contact with Freescale, too, but up to now with little
> > success. The company I'm working for at the moment would also welcome a
> > solution here.
> 
> Sorry for the delay. I have been on holidays.

I wonder who granted you to go on holidays given that we have
problems :-)

> Can you confirm you have both SAIF interfaces being clocked from ref_pll?

root at hostname:/sys/kernel/debug/clk find -name saif?_sel
./ref_xtal/pll0/saif0_sel
./ref_xtal/pll0/saif1_sel

root at hostname:/sys/kernel/debug/clk cat ./ref_xtal/pll0/saif?_sel/clk_rate 
480000000
480000000

This is based on 3.10 (but I hope to update soon to 4.4ish). I know that
Lothar uses 4.4. Also Lothar noticed that disabling one of these
saif_sel clocks doesn't make an impression on the interfaces, they just
continue to run. Maybe a clock is routed in a wrong way?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
