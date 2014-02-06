From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 6 Feb 2014 13:51:28 -0500
Subject: [PATCH] ARM: mm: Fix the memblock allocation for LPAE machines
In-Reply-To: <20140206184153.GV26684@n2100.arm.linux.org.uk>
References: <1391285687-20534-1-git-send-email-santosh.shilimkar@ti.com>
 <52F2CBC0.3030305@ti.com> <20140205234815.GU26684@n2100.arm.linux.org.uk>
 <52F2DC6F.8070005@ti.com> <20140206184153.GV26684@n2100.arm.linux.org.uk>
Message-ID: <52F3D9B0.40505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 February 2014 01:41 PM, Russell King - ARM Linux wrote:
> On Wed, Feb 05, 2014 at 07:50:55PM -0500, Santosh Shilimkar wrote:
>> On Wednesday 05 February 2014 06:48 PM, Russell King - ARM Linux wrote:
>>> On Wed, Feb 05, 2014 at 06:39:44PM -0500, Santosh Shilimkar wrote:
>>>> Russell,
>>>>
>>>> On Saturday 01 February 2014 03:14 PM, Santosh Shilimkar wrote:
>>>>> Commit ad6492b8 added much needed memblock_virt_alloc_low() and further
>>>>> commit 07bacb3 {memblock, bootmem: restore goal for alloc_low} fixed the
>>>>> issue with low memory limit thansk to Yinghai. But even after all these fixes,
>>>>> there is still one case where the limit check done with ARCH_LOW_ADDRESS_LIMIT
>>>>> for low memory fails. Russell pointed out the issue with 32 bit LPAE machines
>>>>> in below thread.
>>>>> 	https://lkml.org/lkml/2014/1/28/364
>>>>>
>>>>> Since on some LPAE machines where memory start address is beyond 4GB,
>>>>> the low memory marker in memblock will be set to default
>>>>> ARCH_LOW_ADDRESS_LIMIT which is wrong. We can fix this by letting
>>>>> architectures set the ARCH_LOW_ADDRESS_LIMIT using another export
>>>>> similar to memblock_set_current_limit() but am not sure whether
>>>>> its worth the trouble. Tell me if you think otherwise.
>>>>>
>>>>> Rather am just trying to fix that one broken case using memblock_virt_alloc()
>>>>> in setup code since the memblock.current_limit is updated appropriately
>>>>> makes it work on all ARM 32 bit machines.
>>>>>
>>>>> Cc: Yinghai Lu <yinghai@kernel.org>
>>>>> Cc: Russell King <linux@arm.linux.org.uk>
>>>>> Cc: Strashko, Grygorii <grygorii.strashko@ti.com>
>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>> ---
>>>> Whats you say here ? We should get the fix for the
>>>> issue. If you are ok, I can drop the patch in patch system.
>>>
>>> Is this still an issue, or has Tejun fixed it by some other means?  I've not
>>> noticed anything being broken at the moment.
>>>
>>> Can you confirm whether we still have an issue without this patch please?
>>>
>> Fixes for all cases exist except 'LPAE + memory start beyond 4 GB'.
>> This case is still broken and  hence I posted the $subject patch.
> 
> Okay.  Patch system please then.  Thanks.
> 
Thanks.  patch 7952/1

Regards,
Santosh
