From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 8 Feb 2013 20:19:08 +0530
Subject: [PATCH V5] ARM: LPAE: Fix mapping in alloc_init_section for
 unaligned addresses
In-Reply-To: <CANOGCgMEdae53GGGNxU6eHqrNLOhZ1wUyXfADEooLkmZ3bC7Og@mail.gmail.com>
References: <1360323019-30139-1-git-send-email-r.sricharan@ti.com>
 <CANOGCgMEdae53GGGNxU6eHqrNLOhZ1wUyXfADEooLkmZ3bC7Og@mail.gmail.com>
Message-ID: <51151064.6050400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 February 2013 08:13 PM, Christoffer Dall wrote:
> On Fri, Feb 8, 2013 at 6:30 AM, R Sricharan <r.sricharan@ti.com> wrote:
>> With LPAE enabled, alloc_init_section() does not map the entire
>> address space for unaligned addresses.
>>
>> The issue also reproduced with CMA + LPAE. CMA tries to map 16MB
>> with page granularity mappings during boot. alloc_init_pte()
>> is called and out of 16MB, only 2MB gets mapped and rest remains
>> unaccessible.
>>
>> Because of this OMAP5 boot is broken with CMA + LPAE enabled.
>> Fix the issue by ensuring that the entire addresses are
>> mapped.
>>
>> Signed-off-by: R Sricharan <r.sricharan@ti.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Christoffer Dall <chris@cloudcar.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Tested-by: Christoffer Dall <chris@cloudcar.com>
>
> I don't think that I've tested this version of the patch, but ok.
>
Indeed. Neither I have acke'd the updated version ;)
Tags from old patch doesn't apply anymore when patch
is completely revamped.

Regards,
Santosh
