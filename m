From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Mar 2017 11:49:19 +0000
Subject: [PATCH 00/14] arm_pmu: ACPI support
In-Reply-To: <5b5dca5f-0ea3-d7e7-63c9-dba57969d4be@arm.com>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
 <5b5dca5f-0ea3-d7e7-63c9-dba57969d4be@arm.com>
Message-ID: <20170314114508.GA15740@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 10, 2017 at 04:14:57PM -0600, Jeremy Linton wrote:
> On 03/10/2017 05:04 AM, Mark Rutland wrote:
> >This series implements ACPI support in the ARM PMU code.

> I tried these patches on a m400 (which uses PPIs), and the kernel
> fails to come up enough to login via the network (which works with
> 4.11rc1 without these patches). So, I suspect there is something
> wrong with them. 

Indeed; sorry about this. I'll see if I can get access to a board to try
local debugging.

I assume that these have successfully booted with the other ACPI PMU
patches?

> Given that SPCR/etc is also broken and the kernel itself seems to
> fail if I give it a full earlycon line, I can't pin down whats going
> on with the PMU code until I fix the console.

If there are known broken tables, it's possible that the MADT GICC is
also broken, and we're registering/unregistering an erroneously
described interrupt.

> About the only thing it says with any meaning when earlycon is passed is:
> [   10.965147] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [   11.064193] dw-apb-uart APMC0D08:00: cannot get irq
> 
> and promptly hangs up.

I guess that's at the point it transfers over to the real console
driver. If you're not already doing so, also passing "keep_bootcon" may
get more output.

> I'm OOO for the next week, and will debug this further when I return
> if no one else makes any progress.

I'll see what I can do until then.

Thanks,
Mark.
