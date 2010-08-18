From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 18 Aug 2010 16:04:40 +0200
Subject: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
In-Reply-To: <201008171336.29375.arnd@arndb.de>
References: <cover.1281956490.git.richard.cochran@omicron.at>
	<201008170925.55592.arnd@arndb.de>
	<20100817105232.GA9079@riccoc20.at.omicron.at>
	<201008171336.29375.arnd@arndb.de>
Message-ID: <20100818140440.GA22655@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 17, 2010 at 01:36:29PM +0200, Arnd Bergmann wrote:
> On Tuesday 17 August 2010, Richard Cochran wrote:
> > I've been looking at offering the PTP clock as a posix clock, and it
> > is not as hard as I first thought. The PTP clock or clocks just have
> > to be registered as one of the posix_clocks[MAX_CLOCKS] in
> > posix-timers.c.
> 
> Ok sounds good.

I've been working turning the PTP stuff into syscalls, but here is a
little issue I ran into. The PTP clock layer wants to call the PPS
code via pps_register_source(), but the PPS can be compiled as a
module. Since the PTP layer is now offering syscalls, it must always
be present in the kernel. So I need to make sure that the PPS is
either absent entirely or staticly linked in.

How can I do this?

Thanks,

Richard
