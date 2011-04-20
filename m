From: khilman@ti.com (Kevin Hilman)
Date: Wed, 20 Apr 2011 16:59:16 -0700
Subject: [v2 0/7] OMAP: GPIO: Use PM runtime framework
In-Reply-To: <20110419062633.GA15620@atomide.com> (Tony Lindgren's message of
	"Tue, 19 Apr 2011 09:26:33 +0300")
References: <1303139217-10285-1-git-send-email-charu@ti.com>
	<20110419062633.GA15620@atomide.com>
Message-ID: <87r58w4gq3.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Tony Lindgren <tony@atomide.com> writes:

> * Varadarajan, Charulatha <charu@ti.com> [110418 18:00]:
>> From: Charulatha V <charu@ti.com>
>> 
>> Use PM runtime framework in OMAP GPIO driver.
> ...
>  
>>  arch/arm/mach-omap2/gpio.c             |    6 +
>>  arch/arm/mach-omap2/pm34xx.c           |   22 +-
>>  arch/arm/plat-omap/gpio.c              |  766 ++++++++++++++++++--------------
>>  arch/arm/plat-omap/include/plat/gpio.h |    3 +-
>>  4 files changed, 439 insertions(+), 358 deletions(-)
>
> Before this series gets merged we first need to do the following:
> - Pass some registers in platform_data so we can have common
>   functions in gpio.c instead of having to test for the bank->method
>   in each function. This allows getting rid of the ifdefs as
>   discussed in the ARM Linux consolidation thread.

I have a series that starts this process, will post it shortly.

> - Move it to drivers/gpio
>
> - Further consolidate with whatever common GPIO code might
>   be coming up.

Is the above order required?

IMO, before we move it to drivers/gpio, this code needs to be runtime PM
converted (using this series from Charu.)  The runtime PM conversion
removes a bunch of platform-specific hacks that should be moved into
drivers/*.

Personally, I think we should go in this order

- runtime PM conversion
- #ifdef cleanup
- move to drivers/gpio
- look at consolidation with other drivers

I'm willing to queue the GPIO work in my tree while it's under way if
you like as well.

Kevin
