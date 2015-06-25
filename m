From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Thu, 25 Jun 2015 11:43:50 -0700
Subject: [PATCH] ARM: use phys_addr_t in pfn_to_kaddr()
In-Reply-To: <alpine.LFD.2.11.1506251232050.2617@knanqh.ubzr>
References: <1435072386-13527-1-git-send-email-vitalya@ti.com>
 <558B0388.1040006@oracle.com>
 <alpine.LFD.2.11.1506251232050.2617@knanqh.ubzr>
Message-ID: <558C4BE6.20009@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/25/2015 9:33 AM, Nicolas Pitre wrote:
> On Wed, 24 Jun 2015, santosh shilimkar wrote:
>
>> On 6/23/2015 8:13 AM, Vitaly Andrianov wrote:
>>> This patch fixes pfn_to_kaddr() to use phys_addr_t.  Without this,
>>> this macro is broken on LPAE systems. For physical addresses above
>>> first 4GB result of shifting pfn with PAGE_SHIFT may be truncated.
>>>
>>> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
>>> ---
>> Looks a valid fix.
>>
>> RMK, Nico, what you say ?
>
> Looks fine to me.
>
> Acked-by: Nicolas Pitre <nico@linaro.org>
>
Thanks Nico.

Vitaly,
I suggest you to drop this patch into RMK's patch system with
mine and Nico's ack.

Regards,
Santosh
