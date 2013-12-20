From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 20 Dec 2013 18:05:15 -0500
Subject: [PATCH] mm/ARM: fix ARMs __ffs() to conform to avoid warning
 with NO_BOOTMEM
In-Reply-To: <20131220225541.GN4360@n2100.arm.linux.org.uk>
References: <1386981486-3173-1-git-send-email-santosh.shilimkar@ti.com>
 <52B4C71D.9030904@ti.com> <20131220225541.GN4360@n2100.arm.linux.org.uk>
Message-ID: <52B4CD2B.3080100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 December 2013 05:55 PM, Russell King - ARM Linux wrote:
> On Fri, Dec 20, 2013 at 05:39:25PM -0500, Santosh Shilimkar wrote:
>> Russell,
>>
>> On Friday 13 December 2013 07:38 PM, Santosh Shilimkar wrote:
>>> Building ARM with NO_BOOTMEM generates below warning.
>>>
>>> mm/nobootmem.c: In function _____free_pages_memory___:
>>> mm/nobootmem.c:88:11: warning: comparison of distinct pointer types lacks a cast
>>>
>>> 	order = min(MAX_ORDER - 1UL, __ffs(start));
>>>
>>> ARM's __ffs() differs from other architectures in that it ends up being
>>> an int, whereas almost everyone else is unsigned long.
>>>
>>> So fix ARMs __ffs() to conform to other architectures. Suggested by
>>> Russell King <linux@arm.linux.org.uk>
>>>
>>> Some more details in below thread -
>>> 	https://lkml.org/lkml/2013/12/9/807
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> ---
>> Is this patch inline with what we discussed off-list ?
> 
> It is.
> 
>> If you ack it, it can go into the Andrews tree to kill that one last
>> warning with the memblock series. Thanks
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
Great !!
 
Andrew,
Can you please pick the $subject patch as well in your
mm tree ? Thanks

regards,
Santosh
