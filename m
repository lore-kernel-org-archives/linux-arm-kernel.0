From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jun 2012 11:08:51 +0100
Subject: [PATCH v2 REBASE] ASoC: fsl_ssi: convert to use devm_clk_get
In-Reply-To: <20120605100316.GG23408@opensource.wolfsonmicro.com>
References: <1338774174-3960-1-git-send-email-richard.zhao@freescale.com>
 <20120605064714.GL30400@pengutronix.de>
 <20120605100316.GG23408@opensource.wolfsonmicro.com>
Message-ID: <20120605100851.GI8262@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2012 at 11:03:16AM +0100, Mark Brown wrote:
> On Tue, Jun 05, 2012 at 08:47:14AM +0200, Sascha Hauer wrote:
> 
> > Have you tried compiling this on PowerPC? devm_clk_get is only available
> > with CONFIG_CLKDEV_LOOKUP, I think on PowerPC this is not the case.
> 
> I've not, but I guess there will be an issue.  I'd say the fix here is
> on the PowerPC side - it's not good to have to have Kconfig bodges for
> things like this in individual drivers.  Ideally we'd add clkdev
> support...

Or get rid of devm_clk_get()'s dependency on CLKDEV (which is in itself
silly.)
