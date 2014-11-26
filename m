From: rogerq@ti.com (Roger Quadros)
Date: Wed, 26 Nov 2014 13:22:50 +0200
Subject: [PATCH 3/3] memory: gpmc: Move omap gpmc code to live under
 drivers
In-Reply-To: <20141124154403.GB2817@atomide.com>
References: <1416594856-15201-1-git-send-email-tony@atomide.com>
 <1416594856-15201-4-git-send-email-tony@atomide.com>
 <547301AB.9040905@ti.com> <20141124154403.GB2817@atomide.com>
Message-ID: <5475B80A.5010207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/11/14 17:44, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [141124 02:02]:
>> On 11/21/2014 08:34 PM, Tony Lindgren wrote:
>>> --- a/drivers/memory/Kconfig
>>> +++ b/drivers/memory/Kconfig
>>> @@ -41,6 +41,14 @@ config TI_EMIF
>>>  	  parameters and other settings during frequency, voltage and
>>>  	  temperature changes
>>>  
>>> +config OMAP_GPMC
>>> +	bool
>>
>> We should depend on ARCH_OMAP2PLUS. Other platforms won't benefit
>> anything from this driver.
> 
> We can't do that yet until we have sorted out the remaining platform
> data issues with arch/arm/mach-omap2/*gpmc*.c files.
> 
> So OMAP_GPMC is currently a silent Kconfig option that does not show
> up as the description after the bool is not there, we select
> OMAP_GPMC automatically based on ARCH_OMAP2PLUS.
> 
> Once we have the remaining legacy code issues sorted out, we can
> make this into just a regular device driver.

OK. In that case,

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger
