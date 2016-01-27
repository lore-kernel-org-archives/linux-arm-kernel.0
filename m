From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 27 Jan 2016 15:43:40 +0100
Subject: noise issues when recording sound on i.MX28
In-Reply-To: <CAOMZO5BpLen517q2heramSta-R6pdESkjM6w=7FRMZebY6ue-Q@mail.gmail.com>
References: <20160127105613.GC13664@pengutronix.de>
 <CAOMZO5BpLen517q2heramSta-R6pdESkjM6w=7FRMZebY6ue-Q@mail.gmail.com>
Message-ID: <20160127144340.GD13664@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

[dropping Jack Lee from Cc: as his address doesn't exist.]

On Wed, Jan 27, 2016 at 09:53:18AM -0200, Fabio Estevam wrote:
> On Wed, Jan 27, 2016 at 8:56 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > I currently work with an i.MX28 based machine and occasionally when
> > recording sound with arecord but no microphone connected the result
> > contains much noise.
> >
> > I found commits
> >
> >         90ce77d4468e ENGR00285446-3 [MX28] SAIF: Bit Shift in SAIF RX Data
> >         1ea685a12f19 ENGR00285446-2 [MX28] SAIF: Bit Shift in SAIF RX Data
> >         1ca899221d8b ENGR00285446-1 [MX28] SAIF: Bit Shift in SAIF RX Data
> >
> > in the Freescale vendor kernel (branch imx_2.6.35_maintain at
> > git://git.freescale.com/imx/linux-2.6-imx.git). The kernel running on
> > the machine in question is based on 3.10 with an impressive (that's
> > negative) patch stack on top. I think patches -2 and -3 are not relevant
> > for my setup because the two saif clocks are configured identically if
> > I'm not mistaken. However implementing the soft reset as is done in
> 
> Please make sure that the two saif clocks are configured identically.

I think I have that. According to $debugfs/clk the two saif clocks have
the same parent and frequency.

> This was the most important part of the fix when we worked on this
> problem on 2.6.35.

So you didn't hit the problem that resetting a saif didn't work, right?

Do you have a few more technical details here? A usecase of my machine
is recording and playback at the same time (an intercom system). So if
it's necessary to reset the sending side to start receiving that's
unfortunate.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
