From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 01 Feb 2011 13:34:59 +0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <20110201111821.GC31216@n2100.arm.linux.org.uk>
References: <20110124133513.GL16202@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F43295@GEORGE.Emea.Arm.com>
	<20110124162400.GC24104@n2100.arm.linux.org.uk>
	<000101cbbbe5$45d47ed0$d17d7c70$@moll@arm.com>
	<20110124165356.GG24104@n2100.arm.linux.org.uk>
	<20110124170304.GH24104@n2100.arm.linux.org.uk>
	<000201cbbbef$bcec4610$36c4d230$@moll@arm.com>
	<20110124180944.GK24104@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F432EF@GEORGE.Emea.Arm.com>
	<20110124231050.GP24104@n2100.arm.linux.org.uk>
	<20110201111821.GC31216@n2100.arm.linux.org.uk>
Message-ID: <1296567299.2768.40.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> And to prove the point, I have MMCI running at up to 4Mbps, an 8 fold
> increase over what the current fixed upper-rate implementation does.
> The adaptive rate implementation is just a proof of concept at the
> moment and requires further work to improve the rate selection algorithm.

Great, I've terribly glad you managed to have a go at this (I honestly
wanted to, but simply had no time). I'm looking forward to see the
patches and will be more than happy to backport them for the sake of the
Linaro guys using 2.6.35 and 2.6.37 right now.

On our side we did extend the FIFO and performed some tests (not very
extensive yet though). The change seems not to break anything and help
in the pathological (heavy USB traffic) scenario.

When I get your changes and some official FPGA release, I'll try to push
the bandwidth limits even further - hopefully changes will complement.
Of course there is absolutely no need of using the modified version if
one opts not to do so ;-) It's just a line in the board configuration
file, selecting one FPGA image or the other - they have different
"configuration value" in the peripheral ID so the driver can distinguish
them.

> The real solution to this is for there to be proper working DMA support
> implemented on ARM platforms,

In case of VE this is all about getting an engine into the test chips,
what didn't happen for A9 (the request lines are routed between the
motherboard and the tile and IO FPGA can - theoretically - use the MMCI
requests). As far as I'm told this cell is simply huge (silicon-wise)
and therefore it's the first candidate to cut down when area is
scarce... Anyway, I've spoken to guys around and asked them to keep the
problem in mind, so we may get something with the next releases.

Cheers!

Pawe?
