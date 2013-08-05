From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 5 Aug 2013 11:47:52 -0400
Subject: [PATCH] WIP: HACK: LPAE, BOOTMEM and NO_BOOTMEM
In-Reply-To: <20130805153822.GD19631@mtj.dyndns.org>
References: <20130629195549.GE3353@n2100.arm.linux.org.uk>
 <CAE9FiQUoVNvWmmTV2+ZkU_nMxFToTHw6QLwp_Z_EjwMzqdLwuA@mail.gmail.com>
 <51D18DBA.6090608@ti.com> <51F1A7AA.8080700@ti.com>
 <20130725223658.GJ26107@mtj.dyndns.org> <51F1B17F.30902@ti.com>
 <20130726030812.GB30195@mtj.dyndns.org> <51FC1F3A.8090201@ti.com>
 <20130805150127.GC19631@mtj.dyndns.org> <51FFC4EA.40908@ti.com>
 <20130805153822.GD19631@mtj.dyndns.org>
Message-ID: <51FFC928.8020603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 August 2013 11:38 AM, Tejun Heo wrote:
> Hello,
> 
> On Mon, Aug 05, 2013 at 11:29:46AM -0400, Santosh Shilimkar wrote:
>> So looks like I am bit confused here. The current memblock_alloc()
>> API just returns the physical address which not mapped memory.
> 
> The memory returned by memblock is mapped if the memory area being
> allocated can be mappable.  To access, the address just needs to be
> converted to va.
> 
>> Most of the bootmem users including core code expects the
>> mapped memory pointer which the code can directly operate on.
>> So the current memblock_alloc() isn't going to help. The nobootmem.c
>> has __alloc_memory_core_early() which is actually used by most of
>> the bootmem wrappers to achieve the same. So my assumption was
>> that we need an equivalent exported memblock API.
>>
>> What am I missing?
> 
> Oh, you weren't.  I was.  I thought we already had full interface
> implemented.  Yeah, it looks like we need to build something new
> around memblock / __alloc_memory_core_early().
> 
Exactly. This is what actually I referred as the new API.

Regards,
Santosh
