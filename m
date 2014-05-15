From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 15 May 2014 09:47:24 +0200
Subject: [RFC PATCH 0/5] Frequency resolution in CCF vs. cpufreq
In-Reply-To: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <20140515074724.GJ16662@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 03:30:50PM -0700, Soren Brinkmann wrote:
> Hi,
> 
> I have one or two problems with cpufreq and the CCF, which are caused by
> rounding/different frequency resolutions.
> 
> cpufreq works with kHz, while the CCF uses Hz. On Zynq our default frequency is
> 666666666 Hz which the CCF, due to rounding, reports as 666666660. And for
Why does this happen? Isn't that a bug? What is the actual freqency?
666666666 Hz or 2000000000/3 Hz?

> cpufreq, which simply divides values it obtains through clk_round_rate() by
> 1000, 666666.
> Since passing 666666 to clk_round_rate() does not result in 666666660
> (clk_round_rate() always rounds down!), we chose to put 666667 in the OPP. This
What is OPP?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
