From: thomas@koeller.dyndns.org (Thomas Koeller)
Date: Sat, 6 Mar 2010 14:07:12 +0100
Subject: DMA using data buffer vmapped in kernel space
In-Reply-To: <20100304213634.GH13417@n2100.arm.linux.org.uk>
References: <201003042211.28569.thomas@koeller.dyndns.org>
	<20100304213634.GH13417@n2100.arm.linux.org.uk>
Message-ID: <201003061407.12698.thomas@koeller.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 4. M?rz 2010 22:36:34 schrieb Russell King - ARM Linux:
> Cache maintainence is done using virtual addresses for L1, and
> physical addresses for L2.  There's the need for virtual addresses
> to be translatable to physical addresses, which is only true for
> the kernel direct mapped region (pages between PAGE_OFFSET and
> high_memory).

Isn't the mapping created by vmap() sufficient for the virt/phys
translation? In which way is this case different from a buffer
passed in from user space, where the constituent pages are not
in the directly mapped kernel region either?

tk
