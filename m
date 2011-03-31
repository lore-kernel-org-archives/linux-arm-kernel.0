From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 31 Mar 2011 20:09:54 +0530
Subject: [pm-core][PATCH v3 02/21] OMAP4: Use WARN_ON() instead of BUG_ON()
	with graceful exit
In-Reply-To: <87wrjfmlnp.fsf@ti.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>	<1301304157-2466-3-git-send-email-santosh.shilimkar@ti.com>	<20110328205323.GD30616@atomide.com>
	<4D943CB8.70002@ti.com> <87wrjfmlnp.fsf@ti.com>
Message-ID: <4D94923A.5060006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/31/2011 7:34 PM, Kevin Hilman wrote:
> Santosh Shilimkar<santosh.shilimkar@ti.com>  writes:
>
>> On 3/29/2011 2:23 AM, Tony Lindgren wrote:
>>> * Santosh Shilimkar<santosh.shilimkar@ti.com>   [110328 02:20]:
>

[...]

>> L2 cache is no problem and kernel can boot without L2 cache
>> support. I agree with you on interrupt controller init though.
>>
>> Will drop the interrupt related checks from this patch.
>>
>> Kevin, Are you ok with it ?
>
> In general, BUG should only be used when the kernel really can not
> possibly continue[1].  I suppose inability to map the GIC falls into
> that category.
>
Thanks. Will drop GIC ones.

Regards
Santosh
