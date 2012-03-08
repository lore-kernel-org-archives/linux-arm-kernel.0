From: khilman@ti.com (Kevin Hilman)
Date: Thu, 08 Mar 2012 10:32:05 -0800
Subject: [PATCH] mmc: omap_hsmmc: Fix Unbalanced pm_runtime_enable warning
In-Reply-To: <87obsaio93.fsf@ti.com>
References: <20120305234240.GQ12083@atomide.com> <87obsaio93.fsf@ti.com>
Message-ID: <4F58FB25.8020602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On 03/05/2012 04:09 PM, Kevin Hilman wrote:
> Tony Lindgren<tony@atomide.com>  writes:
>
>> mmc: omap_hsmmc: Fix Unbalanced pm_runtime_enable warning
>>
>> Otherwise we can get following warning when re-loading the
>> omap_hsmmc driver module when gpio_twl4030 module is not
>> loaded:
>>
>> omap_hsmmc omap_hsmmc.0: Unbalanced pm_runtime_enable!
>> omap_hsmmc omap_hsmmc.0: Unable to grab MMC CD IRQ
>> omap_hsmmc: probe of omap_hsmmc.0 failed with error -22
>>
>> Signed-off-by: Tony Lindgren<tony@atomide.com>
>> ---
>>
>> Kevin, maybe take a look and see if this is correct and
>> fits into your PM branches?
>
> Looks right to me:
>
> Acked-by: Kevin Hilman<khilman@ti.com>
>
> But this is a fix to the driver itself, so Chris should queue this in
> mmc-next.
>
> Chris, can you take this one?
>

just checking on this to be sure it can make it for v3.4.

Kevin
