From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Jul 2014 22:12:52 +0200
Subject: [PATCH 0/4] ABI updates
In-Reply-To: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
Message-ID: <5967772.rMBIs5rqFN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 July 2014 20:51:34 Russell King - ARM Linux wrote:
> As a result of the recent discussions about android, several issues
> have been identified with existing kernels:
> 
> 1. HWCAP_SWP does not properly reflect whether the SWP instruction
>    should be used.  Turn HWCAP_SWP off on ARMv6+ where the exclusives
>    are available.
> 
> 2. SWP is unsafe when running on a SMP CPU; there is no bus locking
>    between the read and write parts of the instruction execution.
>    Force SWP emulation on ARMv7+ where we can disable the SWP
>    instruction.
> 
> 3. Reporting of alignment faults - kernel mode faults are silent due to
>    the requirements of the network stack, but we can note where the
>    last one occurs.
> 
> Testing reveals that at least my OMAP4430 userspace (supplied from TI)
> executes lots of SWP instructions, which is something that wasn't known
> before this patch.
> 
> Many systems today are not configured with SWP emulation enabled on SMP.
> This means that the SWP instruction is available, but unsafe.

Looks all good to me, just one question for the last patch.

	Arnd
