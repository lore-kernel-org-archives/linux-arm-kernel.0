From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 9 Dec 2013 17:39:39 -0500
Subject: [PATCH v3 01/23] mm/memblock: debug: correct displaying of upper
 memory boundary
In-Reply-To: <20131209215641.GF29143@saruman.home>
References: <1386625856-12942-1-git-send-email-santosh.shilimkar@ti.com>
 <1386625856-12942-2-git-send-email-santosh.shilimkar@ti.com>
 <20131209215641.GF29143@saruman.home>
Message-ID: <52A646AB.1030900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 December 2013 04:56 PM, Felipe Balbi wrote:
> On Mon, Dec 09, 2013 at 04:50:34PM -0500, Santosh Shilimkar wrote:
>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> When debugging is enabled (cmdline has "memblock=debug") the memblock
>> will display upper memory boundary per each allocated/freed memory range
>> wrongly. For example:
>>  memblock_reserve: [0x0000009e7e8000-0x0000009e7ed000] _memblock_early_alloc_try_nid_nopanic+0xfc/0x12c
>>
>> The 0x0000009e7ed000 is displayed instead of 0x0000009e7ecfff
>>
>> Hence, correct this by changing formula used to calculate upper memory
>> boundary to (u64)base + size - 1 instead of  (u64)base + size everywhere
>> in the debug messages.
>>
>> Cc: Yinghai Lu <yinghai@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Tejun Heo <tj@kernel.org>
>> Acked-by: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Very minor patch but perhaps we should Cc: stable here ? not that it
> matters much...
> 
Yeah... No major fix as such from stable perspective.

regards,
Santosh
