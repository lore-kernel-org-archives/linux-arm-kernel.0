From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Jan 2012 17:00:28 +0000
Subject: [PATCH 00/11] Recently pending ARM fixes
In-Reply-To: <20120119153149.GB1068@n2100.arm.linux.org.uk>
References: <20120119153149.GB1068@n2100.arm.linux.org.uk>
Message-ID: <20120119170028.GN1701@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Jan 19, 2012 at 03:31:49PM +0000, Russell King - ARM Linux wrote:
> Below is a summary of a new set of ARM fixes which I've queued up
> today (so far).  The big one is the revert of the changes to
> rtc-sa1100.c, which completely broke the driver.  Of the remainder,
> the bulk are sorting out a few section mismatch warnings.
> 
> The two remaining patches fix a build error with collie and some
> RCU problems seen on SMP platforms, and two other minor patches.
> 
> Most people won't have much interest in this set of fixes, except
> for the rcu patch, so I probably won't push this to Linus for a
> few days (which means the number could grow.)

I have a few pending fixes that I plan to stick into the patch system
tomorrow:

ARM: proc-v7.S: remove HARVARD_CACHE preprocessor guards
ARM: cortex-a7: move proc_info out of !CONFIG_ARM_LPAE block
ARM: vectors: use gate_vma for vectors user mapping
ARM: logical_cpu_map: decouple CPU mapping from SMP
ARM: hotplug: ensure that we copy the affinity mask when migrating IRQs
ARM: cache: assume 64-byte L1 cachelines for ARMv7 CPUs
ARM: vmlinux.lds.S: align the exception fixup table to a 4-byte boundary
ARM: vmlinux.lds.S: do not hardcode cacheline size as 32 bytes

the other bits and pieces I've been hacking on can wait until 3.4.

Cheers,

Will
