From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 18 Feb 2011 22:16:06 +0000
Subject: platform/i2c busses: pm runtime and system sleep
In-Reply-To: <20110218202744.GA19427@n2100.arm.linux.org.uk>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
	<201102181928.05911.rjw@sisk.pl>
	<AANLkTi=j9KeX2TSzMaKMWR6GpXjFcsjp0z8Rt+ArLXiV@mail.gmail.com>
	<201102182120.29977.rjw@sisk.pl>
	<20110218202744.GA19427@n2100.arm.linux.org.uk>
Message-ID: <20110218221606.GB25168@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 08:27:44PM +0000, Russell King - ARM Linux wrote:

> Do we have any pressing need to convert AMBA stuff?  I haven't heard any
> reason yet to convert them to runtime PM - they don't even make any
> runtime PM calls.

There's a bit of a chicken and egg problem in that it's not possible for
devices to make use of runtime PM unless the bus has runtime PM support
implemented - the bus implementation is mandatory, there's no default.
