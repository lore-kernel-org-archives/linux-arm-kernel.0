From: cjb@laptop.org (Chris Ball)
Date: Thu, 08 Mar 2012 23:43:25 -0500
Subject: [PATCH] mmc: omap_hsmmc: Fix Unbalanced pm_runtime_enable warning
In-Reply-To: <4F58FB25.8020602@ti.com> (Kevin Hilman's message of "Thu, 08 Mar
 2012 10:32:05 -0800")
References: <20120305234240.GQ12083@atomide.com> <87obsaio93.fsf@ti.com>
 <4F58FB25.8020602@ti.com>
Message-ID: <m2ty1ypeoi.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 08 2012, Kevin Hilman wrote:
>> Tony Lindgren<tony@atomide.com>  writes:
>>
>>> mmc: omap_hsmmc: Fix Unbalanced pm_runtime_enable warning
>>>
>>> Otherwise we can get following warning when re-loading the
>>> omap_hsmmc driver module when gpio_twl4030 module is not
>>> loaded:
>>>
>>> omap_hsmmc omap_hsmmc.0: Unbalanced pm_runtime_enable!
>>> omap_hsmmc omap_hsmmc.0: Unable to grab MMC CD IRQ
>>> omap_hsmmc: probe of omap_hsmmc.0 failed with error -22
>>>
>>> Signed-off-by: Tony Lindgren<tony@atomide.com>
>>> ---
>>>
>>> Kevin, maybe take a look and see if this is correct and
>>> fits into your PM branches?
>>
>> Looks right to me:
>>
>> Acked-by: Kevin Hilman<khilman@ti.com>
>>
>> But this is a fix to the driver itself, so Chris should queue this in
>> mmc-next.
>>
>> Chris, can you take this one?
>
> just checking on this to be sure it can make it for v3.4.

Thanks, I've pushed this to mmc-next for 3.4 now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
