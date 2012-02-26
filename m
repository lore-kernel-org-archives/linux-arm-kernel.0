From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 26 Feb 2012 17:50:37 +0000
Subject: AT91: How copy kernel code to SRAM and execute?
In-Reply-To: <4F4A6DD5.5040606@emagii.com>
References: <4F4A6DD5.5040606@emagii.com>
Message-ID: <20120226175037.GA4706@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2012 at 06:37:25PM +0100, ARM Linux wrote:
> I am looking for some examples on how to copy a small piece of kernel code
> to internal SRAM and then execute it.

See fncpy.h

> Note that when arch_reset is called, the CPU is no longer executing
> in its normal state.
> It is called from arm_machine_restart in "arch/arm/kernel/process.c"
> which has turned off the caches and setup some direct mapping at lower  
> addresses

You're looking at old kernel code.  Stuff has substantially changed in
this area, and CPU caches are no longer turned off if we're going to do
a hardware based reset.

However, that doesn't negate what you're trying to do, and you'll need
to use fncpy() for portability.

The code which you want to copy must be written carefully in assembly
language, and must be written to be relocatable.
