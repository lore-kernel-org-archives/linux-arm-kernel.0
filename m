From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 14 May 2011 17:12:30 +0100
Subject: [RFC PATCH v2 00/12] Consolidating GIC per-cpu interrupts
In-Reply-To: <4DCD64FC.4090703@ti.com>
References: <1304677997-26947-1-git-send-email-marc.zyngier@arm.com>
	<4DCD64FC.4090703@ti.com>
Message-ID: <20110514171230.2a5ba0c0@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 May 2011 22:36:04 +0530
Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:

Hi Santosh,

> Looks like, this series breaks system wide supsend. Please
> check.
> 
> Regards
> Santosh
> 
> -------
> # echo mem > /sys/power/state
> [   37.503112] PM: Syncing filesystems ... done.
> [   37.552032] Freezing user space processes ... (elapsed 0.01 seconds) 
> done.
> [   37.577545] Freezing remaining freezable tasks ... (elapsed 0.02 
> seconds) done.
> [   37.616210] PM: suspend of devices complete after 5.187 msecs
> [   37.623657] PM: late suspend of devices complete after 1.403 msecs
> [   37.630187] Disabling non-boot CPUs ...
> [   37.731964] CPU1: shutdown
> [   38.285888] Enabling non-boot CPUs ...
> [   38.291137] CPU1: Booted secondary processor
> [   38.291168] CPU1: Unknown IPI message 0x1
> [   38.291168] local_timer: can't register interrupt 413 on cpu 1 (-16)

Blah... We obviously don't stop the timer on secondary CPUs, and then
try to request the interrupt again. I'll have a look on Monday.

Thanks for pointing this out.

	M.
-- 
I'm the slime oozin' out from your TV set...
