From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 12:16:03 +0100
Subject: [PATCH V2 0/6] arm_smp_twd: mpcore_wdt: Fix MPCORE watchdog setup
In-Reply-To: <20110706110548.GA31936@1n450.cable.virginmedia.net>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
	<1309892440-3260-1-git-send-email-vkuzmichev@mvista.com>
	<4E14337F.1050101@arm.com>
	<20110706101456.GN8286@n2100.arm.linux.org.uk>
	<20110706110548.GA31936@1n450.cable.virginmedia.net>
Message-ID: <20110706111603.GS8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 12:05:48PM +0100, Catalin Marinas wrote:
> On Wed, Jul 06, 2011 at 11:14:56AM +0100, Russell King - ARM Linux wrote:
> > Do we know why the calibration was initially introduced?  FWIR, it came
> > from the SMP group in ARM, so I guess they had a reason for it rather
> > than copying x86.
> 
> I think it was introduced because the TWD frequency is half of the CPU
> frequency but the latter may not be known - boot monitor configuration
> could change it.

Okay, that implies we can't have a fixed frequency built into the kernel
then.  For such platforms like the ARM dev boards (realview + vexpress),
I expect we can read the CPU frequency from somewhere like one of the
ICST PLLs.
