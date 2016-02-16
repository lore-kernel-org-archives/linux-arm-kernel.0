From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 16 Feb 2016 20:35:35 +0100
Subject: noise issues when recording sound on i.MX28
In-Reply-To: <CAOMZO5BDjkWi+cQK1-J7ag8Z48tY1Uwofi4EkovN-drSC4_reA@mail.gmail.com>
References: <20160127105613.GC13664@pengutronix.de>
 <CAOMZO5BpLen517q2heramSta-R6pdESkjM6w=7FRMZebY6ue-Q@mail.gmail.com>
 <20160127144340.GD13664@pengutronix.de>
 <CAOMZO5AE6HwBYz7kOFORt0HTojJLSb0MYUbkb_HCshDHy=d27g@mail.gmail.com>
 <20160210150315.GC13664@pengutronix.de>
 <CAOMZO5D5H4F90nse9kyW9KvsJStN-sCGktup4FDPw_zTeNfS2g@mail.gmail.com>
 <20160211084029.GE13664@pengutronix.de>
 <CAOMZO5BDjkWi+cQK1-J7ag8Z48tY1Uwofi4EkovN-drSC4_reA@mail.gmail.com>
Message-ID: <20160216193535.GB32169@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Tue, Feb 16, 2016 at 01:01:19PM -0200, Fabio Estevam wrote:
> On Thu, Feb 11, 2016 at 6:40 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> > root at hostname:/sys/kernel/debug/clk find -name saif?_sel
> > ./ref_xtal/pll0/saif0_sel
> > ./ref_xtal/pll0/saif1_sel
> >
> > root at hostname:/sys/kernel/debug/clk cat ./ref_xtal/pll0/saif?_sel/clk_rate
> > 480000000
> > 480000000
> 
> Ok, what about the SAIF0 and SAIF1 sampling rates: are they always the same?

Lothar found a recipe to reproduce. I didn't try, but it's something
along the lines of (Lothar please correct if I'm wrong):

 - start a recording on one SAIF
 - start playback on the other SAIF
 - using direct access to the registers stop and restart the playback
   SAIF via the RUN bit.

The program I have doesn't provide a reliable reproduction recipe, it
runs in a loop and sometimes need several (>1000) iterations to trigger.
In my setup the sampling rates don't change. The values of
BITCLK_MULT_RATE differ however in my setup, I don't see why though.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
