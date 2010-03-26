From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 26 Mar 2010 14:08:33 +0000
Subject: AACI broken with commit 29a4f2d3
In-Reply-To: <1269611685.807.55.camel@e102109-lin.cambridge.arm.com>
References: <s5h39zou023.wl%tiwai@suse.de>
	<20100325113019.GA6590@n2100.arm.linux.org.uk>
	<s5hvdckskev.wl%tiwai@suse.de> <4BAB4DE8.1030707@mvista.com>
	<1269518557.10064.14.camel@e102109-lin.cambridge.arm.com>
	<20100325121614.GC6590@n2100.arm.linux.org.uk>
	<1269602911.15413.6.camel@localhost.localdomain>
	<1269608410.807.23.camel@e102109-lin.cambridge.arm.com>
	<4BACB256.3020404@mvista.com>
	<1269611685.807.55.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100326140833.GK27692@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 01:54:45PM +0000, Catalin Marinas wrote:

> But the above says "the power down control and status register (0x26) of
> the CODEC". So this refers to the AC97 registers rather than the AACI
> registers. Your patch reads from the AACI registers. The AC97 registers
> I think are access with aaci_ac97_(read|write) functions.

Yes, they are - but note that some CODECs will power up in low power
mode and therefore attempts to read immediately after the controller
probe function starts executing may fail until the controller has issued
a warm reset.
