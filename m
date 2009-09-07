From: mikpe@it.uu.se (Mikael Pettersson)
Date: Mon, 7 Sep 2009 19:31:04 +0200
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <1252337372.23780.73.camel@pc1117.cambridge.arm.com>
References: <4A7AEEB6.5060903@googlemail.com>
	<1250184014.14019.40.camel@pc1117.cambridge.arm.com>
	<1250501311.9858.24.camel@pc1117.cambridge.arm.com>
	<20090817140422.GA10764@n2100.arm.linux.org.uk>
	<1251548848.5030.11.camel@pc1117.cambridge.arm.com>
	<1251707405.7930.7.camel@pc1117.cambridge.arm.com>
	<1252337372.23780.73.camel@pc1117.cambridge.arm.com>
Message-ID: <19109.17240.533530.549263@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas writes:
 > Any opinion on whether the ARM kernel should support dynamic shared
 > objects where not all objects are position-independent? IOW, whether
 > text relocations are allowed to be resolved at run-time rather than
 > compile (static link) time for the dynamic shared objects? AFAICT, there
 > isn't anything in the ARM EABI which would prevent this, so a kernel
 > patch may be needed.

I didn't follow the start of this thread, but what exactly
do you mean by "kernel support" for runtime relocations in
shared objects? As far as I can tell, all that would happen
is that some non-pic .so is mapped somewhere, the user-space
linker runs and fixes relocations (directly or lazily), writes
to COW pages, causing the kernel to copy them to new page frames.

In my book that's just "normal" actions for mmaps and pagefaults.

Is the problem that the kernel has buggy cache maintenance when
COW-ing text pages on this arch?

/Mikael
