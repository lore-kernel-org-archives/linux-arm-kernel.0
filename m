From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 30 Aug 2013 12:25:36 -0400
Subject: [PATCH v2 4/4] ARM: keystone: add PM bus support for clock
 management
In-Reply-To: <87k3j3p2xx.fsf@linaro.org>
References: <1377819404-9671-1-git-send-email-santosh.shilimkar@ti.com>
 <1377819404-9671-5-git-send-email-santosh.shilimkar@ti.com>
 <87k3j3p2xx.fsf@linaro.org>
Message-ID: <5220C780.2060301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 30 August 2013 12:18 PM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> Add runtime PM core support to Keystone SOCs by using the pm_clk
>> infrastructure of the PM core. Patch is based on Kevin's pm_domain
>> work on DaVinci SOCs.
>>
>> Keystone SOC doesn't have depedency to enable clocks in early
>> in the boot and hence the clock and PM bus initialisation is done
>> at subsys_init() level.
>>
>> Cc: Kevin Hilman <khilman@linaro.org>
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  drivers/bus/Makefile          |    2 ++
>>  drivers/bus/keystone_pm_bus.c |   70 +++++++++++++++++++++++++++++++++++++++++
> 
> Maybe I missed some earlier discussion on this, but why drivers/bus?
> 
> I called the davinci stuff 'bus' initially because it piggy-backed the
> platform_bus, but now that we have pm_domains, it's using that, and is
> unrelated the bus.
> 
> Therefore, as with davinci, I suspect this belongs in mach-keystone.
>
There is not much keystone specific code and hence thought it doesn't
have to be part of mach-keystone/*. drivers/bus/* I picked out of hat ;-)
thinking it is much of PM bus code. I couldn't find a better place than
that. Any other better place you can suggest ??
 
> [...]
> 
>> diff --git a/drivers/bus/keystone_pm_bus.c b/drivers/bus/keystone_pm_bus.c
>> new file mode 100644
>> index 0000000..6cc56f1
>> --- /dev/null
>> +++ b/drivers/bus/keystone_pm_bus.c
>> @@ -0,0 +1,70 @@
>> +/*
>> + * PM Bus driver for Keystone2 devices
>> + *
>> + * Copyright 2013 Texas Instruments, Inc.
>> + *	Santosh Shilimkar <santosh.shillimkar@ti.com>
>> + *
>> + * Based on Kevins work on DAVINCI SOCs
>> + *	Kevin Hilman <khilman@ti.com>
> 
> Dead email address (as you know) ;)  You can just leave off the email,
> or use khilman at kernel.org as one that shouldn't change.
> 
Sorry I will fix that. Will use "khilman at kernel.org".

Regards,
Santosh
