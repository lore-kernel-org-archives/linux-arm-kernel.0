From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 16 Mar 2011 11:13:00 +0100
Subject: [PATCH] ARM: S3C64XX: Fix section mismatch from cpufreq init
In-Reply-To: <20110316094959.GB2688@opensource.wolfsonmicro.com>
References: <1299769093-14516-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110316083811.GG13316@pengutronix.de>
	<20110316094959.GB2688@opensource.wolfsonmicro.com>
Message-ID: <20110316101259.GH13316@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2011 at 09:49:59AM +0000, Mark Brown wrote:
> On Wed, Mar 16, 2011 at 09:38:11AM +0100, Uwe Kleine-K?nig wrote:
> > On Thu, Mar 10, 2011 at 02:58:13PM +0000, Mark Brown wrote:
> > > we don't appear to have annotations which allow us to mark that it'll
> > > never be called after system init, causing the linker consistency
> 
> > Actually this is warning is a false positive.  There is a section
> > mismatch, but it is never a problem because the .init callback is only
> > called by cpufreq_register_driver. To get rid of the warning the right
> > fix is to remove the .init callback from struct cpufreq_driver and
> > change the prototype of cpufreq_register_driver to
> 
> That's what I said above, pretty much.  Ideally we'd have a way of
> annotating the call sites so that the linker infrastructure rather than
> having to faff about splitting the structures like this.
You can mark the driver struct using __ref. But IMHO not saving a
reference to a function only used once is cleaner.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
