From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Mar 2012 10:00:33 +0000
Subject: [RFC/PATCH 4/4] pxa: convert to common clock framework
In-Reply-To: <CA+gwMceR=iPpt0Ca=nWEDuR3Y3yp=LTVOrRD--qO4QOnUwKUHA@mail.gmail.com>
References: <1331919483.31118.23.camel@flow>
 <20120317160744.GE29317@pengutronix.de>
 <CA+gwMceR=iPpt0Ca=nWEDuR3Y3yp=LTVOrRD--qO4QOnUwKUHA@mail.gmail.com>
Message-ID: <201203191000.33905.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 March 2012, Philipp Zabel wrote:

> Thanks, this is exactly what I was looking for.
> 
> I'm a bit wary of adding so many clocks that just represent fixed
> hardware, especially with the amount of function calls needed.
> But describing the clock tree correctly appeals to my sense of order.
> 
> What is the take of the PXA maintainers on this?
> Are there maybe plans to add device tree support for PXA?
> 

Haojian Zhuang has been busy posting DT patches recently. The patches
ended up being too late for v3.4, but I expect the first set to get
submitted for arm-soc after the merge window has ended.

There is still some infrastructure work required, e.g. in the interrupt
controller, but things will be easier after -rc1 when the irqdomain and
clk support is merged.

	Arnd
