From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 06 Nov 2011 21:48:54 -0500 (EST)
Subject: [01: PATCH 0/7] Preparation for arch_reset changes
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1111062147070.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 6 Nov 2011, Russell King - ARM Linux wrote:

> This series lays down the ground work for changing the way we handle the
> reset (now called restart) handling on ARM.
> 
> As a result of these patches, we provide a new hook in the machine_desc
> record called 'restart' which is pointed at a function to perform the
> appropriate restart actions for the platform.  This is called directly
> from machine_restart() with IRQs and caches on.
> 
> The 'soft_reboot' flag is changed to a more generic 'restart_mode'
> character - which is used to initialize the default reboot mode (which
> can be changed via the 'reboot=' command line parameter.)
> 
> 'soft_restart(addr)' is added which performs a soft restart (iow,
> orderly shutdown of caches and MMU and a jump to the passed address),
> rather than the old way which separated the tear-down of the caches
> and MMU from the code doing the jump.  This will be necessary to
> resolve the ARMv6 and ARMv7 CPU restarting problems.
> 
> Finally, appropriate 'restart_mode' values are added to several
> platforms which were hard-coding the restart mode by intercepting
> the restarting via arm_pm_restart.

This series (the 7 patches) looks good to me.

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
