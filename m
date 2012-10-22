From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 22 Oct 2012 14:27:11 +0100
Subject: [PATCH] clk: Make the generic clock API available by default
In-Reply-To: <20121022130556.GM21164@n2100.arm.linux.org.uk>
References: <1350910970-9095-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20121022130556.GM21164@n2100.arm.linux.org.uk>
Message-ID: <20121022132711.GE4477@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 02:05:57PM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 22, 2012 at 02:02:50PM +0100, Mark Brown wrote:
> > @@ -327,6 +328,7 @@ config ARCH_AT91
> >  	select ARCH_REQUIRE_GPIOLIB
> >  	select CLKDEV_LOOKUP
> >  	select HAVE_CLK
> > +	select HAVE_CUSTOM_CLK

> This is silly.  If you select "HAVE_CUSTOM_CLK" then isn't it true that
> "HAVE_CLK" should also be selected?  If so, why not have "HAVE_CUSTOM_CLK"
> do that selection and remove it from all these entries?

If we're worrying about that there's the larger point that the effect of
this patch is to make HAVE_CLK meaningless as there will be no platform
for which it's not true.  I was just leaving HAVE_CLK alone for now
ready to circle around on it if we ever manage to get the enabling bit
sorted.
