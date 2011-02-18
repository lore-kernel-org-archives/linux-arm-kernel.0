From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Feb 2011 20:27:44 +0000
Subject: platform/i2c busses: pm runtime and system sleep
In-Reply-To: <201102182120.29977.rjw@sisk.pl>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
	<201102181928.05911.rjw@sisk.pl>
	<AANLkTi=j9KeX2TSzMaKMWR6GpXjFcsjp0z8Rt+ArLXiV@mail.gmail.com>
	<201102182120.29977.rjw@sisk.pl>
Message-ID: <20110218202744.GA19427@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 09:20:29PM +0100, Rafael J. Wysocki wrote:
> On Friday, February 18, 2011, Rabin Vincent wrote:
> > Looking at the i2c drivers using runtime pm in comparison, they all seem
> > to be using straightforward UNIVERSAL_PM_OPS-style code with the runtime
> > and the system sleep doing the same things.  So maybe we do need to
> > treat platform/AMBA different from the I2C/SPI group?
> 
> We probably do.

Do we have any pressing need to convert AMBA stuff?  I haven't heard any
reason yet to convert them to runtime PM - they don't even make any
runtime PM calls.

Maybe Linus can comment on the PM stuff as he has SoCs with these in.
As my boards don't have any sensible PM support, I don't have any
visibility of what PM facilities would be required.
