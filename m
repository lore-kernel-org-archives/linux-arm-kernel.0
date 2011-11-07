From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 7 Nov 2011 11:24:43 -0600
Subject: [01: PATCH 0/7] Preparation for arch_reset changes
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F39DF784A7@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, November 06, 2011 10:31 AM, Russell King wrote:
>
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

Russell,

You already have my Acked-by for the ep93xx part of patch 7.

But, FWIW, the rest of this series also looks good to me.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
