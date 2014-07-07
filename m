From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Jul 2014 06:23:29 -0700
Subject: [PATCH 0/4] ABI updates
In-Reply-To: <20140707112322.GA21766@n2100.arm.linux.org.uk>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
 <20140707111947.GP28884@atomide.com>
 <20140707112322.GA21766@n2100.arm.linux.org.uk>
Message-ID: <20140707132329.GX28884@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [140707 04:25]:
> On Mon, Jul 07, 2014 at 04:19:48AM -0700, Tony Lindgren wrote:
> > 
> > Tried testing this on omap2 which is ARMv6 with no K, but got this:
> > 
> > arch/arm/kernel/setup.c: In function ?elf_hwcap_fixup?:
> > arch/arm/kernel/setup.c:405:2: error: implicit declaration of function ?read_cpuid_part? [-Werror=implicit-function-declaration]
> 
> That's because they rely upon my "ARM: make it easier to check the CPU part
> number correctly" patch in linux-next.

OK, works with that patch applied.
 
> > That should be read_cpuid_part_number instead. After fixing that,
> > omap2 booted fine, so for ARMv6 with no K:
> 
> Great, I hope you checked /proc/cpuinfo came out correctly, as well as
> noticing that it merely booted.

Yes it's the same with and without the patches:

# cat /proc/cpuinfo 
processor       : 0
model name      : ARMv6-compatible processor rev 2 (v6l)
Features        : swp half thumb fastmult vfp edsp java 
CPU implementer : 0x41
CPU architecture: 6TEJ
CPU variant     : 0x0
CPU part        : 0xb36
CPU revision    : 2

Hardware        : Generic OMAP2430 (Flattened Device Tree)
Revision        : 0000
Serial          : 0000000000000000

And omap2's have this in the revision registers for reference:

CPU: ARMv6-compatible processor [4107b362] revision 2 (ARMv6TEJ), cr=00c5387d

Regards,

Tony
