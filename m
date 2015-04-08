From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Wed, 08 Apr 2015 10:27:11 -0700
Subject: [PATCH 5/6] ARM: re-implement physical address space switching
In-Reply-To: <20150408163428.3905e7e3@free-electrons.com>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>	<E1YfmY6-0006X3-1N@rmk-PC.arm.linux.org.uk>
 <20150408163428.3905e7e3@free-electrons.com>
Message-ID: <552564EF.4070700@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/8/2015 7:34 AM, Thomas Petazzoni wrote:
> Dear Russell King,
>
> On Wed, 08 Apr 2015 10:45:30 +0100, Russell King wrote:
>> Re-implement the physical address space switching to be architecturally
>> complaint.  This involves flushing the caches, disabling the MMU, and
>
> Nit: s/complaint/compliant/.
>
> But since I'm not going to write an e-mail just for such a small nit,
> here is an hopefully more interesting question: do you think it would
> be possible to use this logic for my Armada 370/XP/375/38x case, where
> I need some specific page table configuration to be able to use HW I/O
> coherency in non-SMP configurations?
>
> If you remember the discussion we had, the primary issue is that the
> page tables are built in arch/arm/kernel/head.S, before we even know
> which SoC we are running on (and the CPU ID available from CP15 is not
> sufficient to determine whether the SoC supports HW I/O coherency). If
> we can get into the SoC-specific code, and at this point decide whether
> and how the page tables should be rebuilt (which is apparently what
> happens in Keystone), then it would be also useful for our case I
> believe.
>
Well Keystone does switch the page tables to use entirely different
memory but what you are talking is, you want to control the page
table attributes for certain pages(memory area). Head.s page tables
are just for boot up. The actual page tables creation happens in
paging_init().

Not sure if you just need a special MT_* area which could take
care of your case but am missing details so no sure.

Regards,
Santosh
