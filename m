From: mikedunn@newsguy.com (Mike Dunn)
Date: Sun, 23 Dec 2012 07:10:02 -0800
Subject: [PATCH 2/3] ARM: pxa: palmtreo: fix #ifdefs for leds-gpio device
In-Reply-To: <201212230420.55725.marex@denx.de>
References: <1356204719-3317-1-git-send-email-mikedunn@newsguy.com>
 <1356204719-3317-3-git-send-email-mikedunn@newsguy.com>
 <201212230420.55725.marex@denx.de>
Message-ID: <50D71ECA.6080005@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2012 07:20 PM, Marek Vasut wrote:
> Dear Mike Dunn,
> 
>> The #ifdefs around the leds-gpio device platform data are erroneous. 
>> Currently the device is not instantiated on the centro unless
>> CONFIG_MACH_TREO680 is defined.
>>
>> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
>> ---
>>
>> The #ifdefs within palmtreo_leds_init() are a little ugly, but I think the
>> only alternative would be to instantiate the leds-gpio device platform
>> data for both treo680 and centro, which would require some of the #defines
>> in palmtreo.h to be moved outside their containing #ifdef
>> CONFIG_MACH_{TREO680,CENTRO}.
> 
> Shall we not just kill all those ifdefs and let GCC decide what to optimize out? 
> I think this kind of simple stuff should just be optimized out anyway.


You're suggesting that all the #ifdef CONFIG_MACH_{TREO680,CENTRO} be removed
from palmtreo.h?  Yes, this might be better.  I'll look into it.

Thanks again,
Mike
