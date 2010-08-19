From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 19 Aug 2010 11:22:47 +0200
Subject: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
In-Reply-To: <201008181702.03384.arnd@arndb.de>
References: <cover.1281956490.git.richard.cochran@omicron.at>
	<201008171336.29375.arnd@arndb.de>
	<20100818140440.GA22655@riccoc20.at.omicron.at>
	<201008181702.03384.arnd@arndb.de>
Message-ID: <20100819092246.GA8484@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 18, 2010 at 05:02:03PM +0200, Arnd Bergmann wrote:
> You might want to use callbacks for these system calls that you
> can register to at module load time, like it is done for the
> existing syscalls.

Can you point me to a specific example?

> The simpler way (e.g. for testing) is using Kconfig dependencies, like
> 
> config PTP
> 	bool "IEEE 1588 Precision Time Protocol"
> 
> config PPS
> 	tristate "Pulse per Second"
> 	depends on PTP || !PTP
> 
> The depends statement is a way of expressing that when PTP is enabled,
> PPS cannot be a module, while it may be a module if PTP is disabled.

THis did not work for me.

What I got was, in effect, two independent booleans.


Thanks,

Richard
