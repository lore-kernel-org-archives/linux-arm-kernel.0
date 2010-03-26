From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 26 Mar 2010 13:24:37 +0000
Subject: AACI broken with commit 29a4f2d3
In-Reply-To: <4BACB256.3020404@mvista.com>
References: <1269443418.29073.147.camel@e102109-lin.cambridge.arm.com>
	<s5h39zou023.wl%tiwai@suse.de>
	<20100325113019.GA6590@n2100.arm.linux.org.uk>
	<s5hvdckskev.wl%tiwai@suse.de> <4BAB4DE8.1030707@mvista.com>
	<1269518557.10064.14.camel@e102109-lin.cambridge.arm.com>
	<20100325121614.GC6590@n2100.arm.linux.org.uk>
	<1269602911.15413.6.camel@localhost.localdomain>
	<1269608410.807.23.camel@e102109-lin.cambridge.arm.com>
	<4BACB256.3020404@mvista.com>
Message-ID: <20100326132436.GI27692@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 06:40:46PM +0530, Philby John wrote:

> I think there is a register at 0x26 for AACI, except that its not  
> defined in aaci.h. References in the manual such as "The AC-link signals
> can be placed in low-power mode, when the power down control
> and status register (0x26) of the CODEC is programmed to the
> appropriate value, both AACIBITCLK and AACISDATAIN are brought to, and  
> held at 0.", refer to this register IMHO.

The AC97 bus is clock mastered by the CODEC, register 0x26 here is the
power down register defined by AC97 for the standard CODEC address map,
not the controller.  Low power mode for the link means that the CODEC
stops driving the clock signals on the bus until a warm reset is done.

There is no standard register map for the controller.
