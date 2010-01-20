From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Jan 2010 16:35:25 +0000
Subject: [PATCH/RFC v1 0/2] Human readable performance event
	description in sysfs
In-Reply-To: <20100120162647.GB7348@shareable.org>
References: <1263978706-15499-1-git-send-email-t.fujak@samsung.com>
	<1263978999.4283.823.camel@laptop> <op.u6tslipz7p4s8u@pikus>
	<20100120133145.GE4089@wear.picochip.com>
	<1263994779.4283.1057.camel@laptop>
	<20100120135553.GA22897@n2100.arm.linux.org.uk>
	<1263996080.4283.1064.camel@laptop>
	<20100120144140.GB22897@n2100.arm.linux.org.uk>
	<20100120162647.GB7348@shareable.org>
Message-ID: <20100120163525.GE27507@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2010 at 04:26:47PM +0000, Jamie Lokier wrote:
> In practice, the list of capabilities works well on x86 in /proc/cpuinfo:
> 
>     flags : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx constant_tsc arch_perfmon bts pni monitor vmx est tm2 xtpr pdcm
> 
> They are based on the feature bits from the CPU's cpuid instruction,
> but the kernel does things like apply errata quirks to remove bits
> that don't work on a particular implementation and show the lowest common
> denominator when there are multiple CPUs.

You're assuming that there's a fixed set of feature bits on ARM.  There
aren't.

What you have is a main ID register up until ARMv6, which has about
four different encodings.  On some CPUs, this is the only ID register
offered, and within that subset, some different CPUs (eg, implemented
by different manufacturers, or indeed the same manufacturer) have the
same ID register value, despite being rather different.
