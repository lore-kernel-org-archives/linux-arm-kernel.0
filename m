From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 15 May 2014 07:00:26 -0700
Subject: [RFC PATCH 0/5] Frequency resolution in CCF vs. cpufreq
In-Reply-To: <20140515074724.GJ16662@pengutronix.de>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
 <20140515074724.GJ16662@pengutronix.de>
Message-ID: <6fe97032-ba6b-4dac-9064-34a9c788c57c@BN1BFFO11FD001.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Thu, 2014-05-15 at 09:47AM +0200, Uwe Kleine-K?nig wrote:
> On Wed, May 14, 2014 at 03:30:50PM -0700, Soren Brinkmann wrote:
> > Hi,
> > 
> > I have one or two problems with cpufreq and the CCF, which are caused by
> > rounding/different frequency resolutions.
> > 
> > cpufreq works with kHz, while the CCF uses Hz. On Zynq our default frequency is
> > 666666666 Hz which the CCF, due to rounding, reports as 666666660. And for
> Why does this happen? Isn't that a bug? What is the actual freqency?
> 666666666 Hz or 2000000000/3 Hz?

I don't know for sure. I think it's rounding that takes place in the
CCF. That output clock goes from a x-tal through an PLL and various
muxes and dividers. I guess some inaccuracies in the magnitude of a few
Hz are probably not avoidable in that processing chain.

> 
> > cpufreq, which simply divides values it obtains through clk_round_rate() by
> > 1000, 666666.
> > Since passing 666666 to clk_round_rate() does not result in 666666660
> > (clk_round_rate() always rounds down!), we chose to put 666667 in the OPP. This
> What is OPP?

As Nishanth already said, Operating Performance Points. Sorry for being
lazy and not having spelled that out.

	S?ren
