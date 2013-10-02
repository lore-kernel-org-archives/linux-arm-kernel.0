From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 2 Oct 2013 13:39:11 -0400
Subject: [PATCH v2 00/12] CPU idle for Armada XP
In-Reply-To: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20131002173911.GP31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory,

On Fri, Sep 13, 2013 at 12:06:29PM +0200, Gregory CLEMENT wrote:
> Hello,
> 
> This patch set adds the CPU idle support for Armada XP and prepares
> the support for Armada 370. This was based on the work of Nadav
> Haklai.
> 
> Most of the patches modify the mvebu code in order to prepare the
> support for CPU idle, hence the patches 2 to 10 should go to mvebu
> subsystem (and then arm-soc).
> 
> The first patch should go through ARM subsystem and should be taken
> by Russell King.
> 
> The 11th patch 'cpuidle: mvebu: Add initial cpu idle support for
> Armada 370/XP SoC' is the only one who should go to the cpuidle
> subsystem. But of course I would like that Daniel Lezcano or Rafael
> J. Wysocki have a look on the whole series.
> 
> The last patch should also go to mvebu subsystem (and then arm-soc)
> but with an Acked-by from on of the device tree maintainer.
> 
> The whole series is also available in the branch CPU-idle-ArmadaXP-v2
> at https://github.com/MISL-EBU-System-SW/mainline-public.git
> 
> Thanks,
> 
> Changelog:
> 
> v1 -> v2:
> 
> * Removed the pm_level kernel parameter. As Kevin Hilman pointed, its
>   usage can be replaced by using
>   /sys/devices/system/cpu/cpu*/cpuidle/state*/disable or the kernel
>   parameter cpuidle.off.
> 
> * Used BIT() macro (reported by Ezequiel)
> 
> * Made the function more readable the
>   armada_370_xp_pmsu_idle_prepare() function (reported by Thomas)
> 
> * Moved the config entry in Kconfig.arm, and rename the config symbol
>   according the pattern used by other arm cpu: ARM_"soc name"_CPUIDLE
> 
> * Moved the build rule under the new ARM SoC section in the Makefile
> 
> * Rebased on Linus Torvalds master branch of Thursday September 12
> 
> Gregory CLEMENT (12):
>   ARM: PJ4B: Add cpu_suspend/cpu_resume hooks for PJ4B
>   ARM: mvebu: ll_set_cpu_coherent no more uses the coherency address as
>     parameter
>   ARM: mvebu: ll_set_cpu_coherent always uses the current CPU
>   ARM: mvebu: Remove the unused argument of set_cpu_coherent()
>   ARM: mvebu: Make ll_set_cpu_coherent() more configurable
>   ARM: mvebu: Low level functions to disable cache snooping
>   ARM: mvebu: Add a new set of registers for pmsu
>   ARM: mvebu: Allow to power down L2 cache controller in idle mode
>   ARM: mvebu: Add the PMSU related part of the cpu idle functions
>   ARM: mvebu: Set the start address of a CPU in a separate function
>   cpuidle: mvebu: Add initial CPU idle support for Armada 370/XP SoC
>   ARM: dts: mvebu: Add a new set of registers to the PMSU node

Is a v3 of this series on it's way?

thx,

Jason.
