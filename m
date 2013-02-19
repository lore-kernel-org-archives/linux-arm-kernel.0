From: horms@verge.net.au (Simon Horman)
Date: Tue, 19 Feb 2013 09:49:00 +0900
Subject: [PATCH 00/08] ARM: shmobile: CPU Hotplug and SMP CA9 SCU rework
 part 2
In-Reply-To: <20130218134648.17303.97576.sendpatchset@w520>
References: <20130218134648.17303.97576.sendpatchset@w520>
Message-ID: <20130219004857.GA14932@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 10:46:48PM +0900, Magnus Damm wrote:
> ARM: shmobile: CPU Hotplug and SMP CA9 SCU rework part 2
> 
> [PATCH 01/08] ARM: shmobile: Fix base address readout in headsmp-scu.S
> [PATCH 02/08] ARM: shmobile: Rework SH73A0_SCU_BASE IOMEM() usage
> [PATCH 03/08] ARM: shmobile: Use R8A7779_SCU_BASE with TWD
> [PATCH 04/08] ARM: shmobile: Update r8a7779 to check SCU for hotplug
> [PATCH 05/08] ARM: shmobile: Update r8a7779 to use scu_power_mode()
> [PATCH 06/08] ARM: shmobile: Use sh73a0-specific cpu disable code
> [PATCH 07/08] ARM: shmobile: Rearrange r8a7779 cpu hotplug code
> [PATCH 08/08] ARM: shmobile: Remove unused hotplug.c
> 
> Finalize the SCU rework by performing minor fixes and converting
> the r8a7779 SMP code to make use of common scu_power_mode() code
> and the early SCU setup code in headsmp-scu.S.
> 
> Also, to save a few line remove hotplug.c while at it.
> 
> The only remaining itch to scratch here is to fix up CPU Hotplug
> of CPU0 on r8a7779, but for that to happen we first need to start
> accounting for spurious interrupts during shut down.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  No known dependencies apart from previous SMP cleanup series
>  "[PATCH 00/06] ARM: shmobile: SMP Cortex-A9 SCU rework"
>  Written against -next in renesas.git.

I believe those are queued up for upstream in the soc5 branch.

Please let me know when you are comfortable with me applying these patches
to that branch. I'm fine with that answer being "now".
