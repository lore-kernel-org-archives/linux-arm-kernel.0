From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 16 Feb 2012 17:46:41 +0100
Subject: [PATCH 2/3] ARM: OMAP2+: Split omap2_hsmmc_init() to properly
 support I2C GPIO pins
In-Reply-To: <20120216163558.GB15692@atomide.com>
References: <20120215182355.18884.18682.stgit@kaulin.local>
 <20120215182825.18884.40972.stgit@kaulin.local> <4F3CD460.7000306@ti.com>
 <4F3CD6CE.1090201@ti.com> <20120216163558.GB15692@atomide.com>
Message-ID: <4F3D32F1.9090507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/16/2012 5:35 PM, Tony Lindgren wrote:
> * Rajendra Nayak<rnayak@ti.com>  [120216 01:42]:
>> On Thursday 16 February 2012 03:33 PM, Rajendra Nayak wrote:
>>> better still, I think we should just populate them statically in
>>> omap2_hsmmc_info struct above, so omap_hsmmc_init() takes care
>>> of it already.
>>
>> I just tried this and it seems to work...
>>
>> ---
>>   arch/arm/mach-omap2/board-omap3beagle.c |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> Index: linux-2.6/arch/arm/mach-omap2/board-omap3beagle.c
>> ===================================================================
>> --- linux-2.6.orig/arch/arm/mach-omap2/board-omap3beagle.c
>> 2012-02-16 15:38:47.046933403 +0530
>> +++ linux-2.6/arch/arm/mach-omap2/board-omap3beagle.c   2012-02-16
>> 15:40:17.355349064 +0530
>> @@ -253,6 +253,7 @@
>>                  .mmc            = 1,
>>                  .caps           = MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
>>                  .gpio_wp        = -EINVAL,
>> +               .gpio_cd        = OMAP_MAX_GPIO_LINES + 0,
>>                  .deferred       = true,
>>          },
>>          {}      /* Terminator */
>
> Would be nice to avoid the hard coded gpio numbering for the
> external chips though..

DT will fix that properly, but I think that any non-DT approach will 
anyway be hacky and require centralized hard coded global GPIO number 
like it is done for the IRQ so far.

Regards,
Benoit
