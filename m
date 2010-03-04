From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Mar 2010 21:36:34 +0000
Subject: DMA using data buffer vmapped in kernel space
In-Reply-To: <201003042211.28569.thomas@koeller.dyndns.org>
References: <201003042211.28569.thomas@koeller.dyndns.org>
Message-ID: <20100304213634.GH13417@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 04, 2010 at 10:11:08PM +0100, Thomas Koeller wrote:
> I do not understand the purpose of the failing check. The virt_addr_valid()
> macro checks whether its argument is below high_memory. But why would the
> virtual address of a DMA data buffer matter at all? After all, the pages
> are resident, so I cannot see any problem here. Can anybody explain?

Cache maintainence is done using virtual addresses for L1, and
physical addresses for L2.  There's the need for virtual addresses
to be translatable to physical addresses, which is only true for
the kernel direct mapped region (pages between PAGE_OFFSET and
high_memory).
