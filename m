From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2011 08:45:11 +0100
Subject: [PATCH] ARM: do not mark CPU 0 as hotpluggable
In-Reply-To: <1311204745-6276-1-git-send-email-mturquette@ti.com>
References: <1311204745-6276-1-git-send-email-mturquette@ti.com>
Message-ID: <20110721074511.GK26574@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 04:32:25PM -0700, Mike Turquette wrote:
> A quick poll of the ARM platforms that implement CPU Hotplug support
> shows that every platform treats CPU 0 as a special case that cannot be
> hotplugged.  In fact every platform has identical code for
> platform_cpu_die which returns -EPERM in the case of CPU 0.

Are you sure that's just not because everyone copied what Realview has
been doing (highly likely)?

I suspect that there's no reason that CPU0 can't be taken down, especially
on those platforms which don't take the CPU fully offline but just put it
into a WFI loop.

Those which restart the CPUs through the boot loader probably detect CPU0
as the boot CPU, so they probably can't take CPU0 down.
