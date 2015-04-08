From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 8 Apr 2015 16:34:28 +0200
Subject: [PATCH 5/6] ARM: re-implement physical address space switching
In-Reply-To: <E1YfmY6-0006X3-1N@rmk-PC.arm.linux.org.uk>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <E1YfmY6-0006X3-1N@rmk-PC.arm.linux.org.uk>
Message-ID: <20150408163428.3905e7e3@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell King,

On Wed, 08 Apr 2015 10:45:30 +0100, Russell King wrote:
> Re-implement the physical address space switching to be architecturally
> complaint.  This involves flushing the caches, disabling the MMU, and

Nit: s/complaint/compliant/.

But since I'm not going to write an e-mail just for such a small nit,
here is an hopefully more interesting question: do you think it would
be possible to use this logic for my Armada 370/XP/375/38x case, where
I need some specific page table configuration to be able to use HW I/O
coherency in non-SMP configurations?

If you remember the discussion we had, the primary issue is that the
page tables are built in arch/arm/kernel/head.S, before we even know
which SoC we are running on (and the CPU ID available from CP15 is not
sufficient to determine whether the SoC supports HW I/O coherency). If
we can get into the SoC-specific code, and at this point decide whether
and how the page tables should be rebuilt (which is apparently what
happens in Keystone), then it would be also useful for our case I
believe.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
