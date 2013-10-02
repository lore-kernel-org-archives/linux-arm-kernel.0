From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 02 Oct 2013 20:44:57 +0300
Subject: [PATCH v2 00/12] CPU idle for Armada XP
In-Reply-To: <20131002173911.GP31178@titan.lakedaemon.net>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
 <20131002173911.GP31178@titan.lakedaemon.net>
Message-ID: <524C5B99.4080802@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On 02/10/2013 20:39, Jason Cooper wrote:
> Gregory,
> 
> On Fri, Sep 13, 2013 at 12:06:29PM +0200, Gregory CLEMENT wrote:
>> Hello,
>>
>> This patch set adds the CPU idle support for Armada XP and prepares
>> the support for Armada 370. This was based on the work of Nadav
>> Haklai.
>>
>> Most of the patches modify the mvebu code in order to prepare the
>> support for CPU idle, hence the patches 2 to 10 should go to mvebu
>> subsystem (and then arm-soc).
>>
>> The first patch should go through ARM subsystem and should be taken
>> by Russell King.
>>
>> The 11th patch 'cpuidle: mvebu: Add initial cpu idle support for
>> Armada 370/XP SoC' is the only one who should go to the cpuidle
>> subsystem. But of course I would like that Daniel Lezcano or Rafael
>> J. Wysocki have a look on the whole series.
>>
>> The last patch should also go to mvebu subsystem (and then arm-soc)
>> but with an Acked-by from on of the device tree maintainer.
>>
>> The whole series is also available in the branch CPU-idle-ArmadaXP-v2
>> at https://github.com/MISL-EBU-System-SW/mainline-public.git
>>
>> Thanks,
>>
>> Changelog:
>>
>> v1 -> v2:
>>
>> * Removed the pm_level kernel parameter. As Kevin Hilman pointed, its
>>   usage can be replaced by using
>>   /sys/devices/system/cpu/cpu*/cpuidle/state*/disable or the kernel
>>   parameter cpuidle.off.
>>
>> * Used BIT() macro (reported by Ezequiel)
>>
>> * Made the function more readable the
>>   armada_370_xp_pmsu_idle_prepare() function (reported by Thomas)
>>
>> * Moved the config entry in Kconfig.arm, and rename the config symbol
>>   according the pattern used by other arm cpu: ARM_"soc name"_CPUIDLE
>>
>> * Moved the build rule under the new ARM SoC section in the Makefile
>>
>> * Rebased on Linus Torvalds master branch of Thursday September 12
>>
>> Gregory CLEMENT (12):
>>   ARM: PJ4B: Add cpu_suspend/cpu_resume hooks for PJ4B
>>   ARM: mvebu: ll_set_cpu_coherent no more uses the coherency address as
>>     parameter
>>   ARM: mvebu: ll_set_cpu_coherent always uses the current CPU
>>   ARM: mvebu: Remove the unused argument of set_cpu_coherent()
>>   ARM: mvebu: Make ll_set_cpu_coherent() more configurable
>>   ARM: mvebu: Low level functions to disable cache snooping
>>   ARM: mvebu: Add a new set of registers for pmsu
>>   ARM: mvebu: Allow to power down L2 cache controller in idle mode
>>   ARM: mvebu: Add the PMSU related part of the cpu idle functions
>>   ARM: mvebu: Set the start address of a CPU in a separate function
>>   cpuidle: mvebu: Add initial CPU idle support for Armada 370/XP SoC
>>   ARM: dts: mvebu: Add a new set of registers to the PMSU node
> 
> Is a v3 of this series on it's way?

Yes I got some feedback from the Marvell engineers about the tricky part.

However I am quite busy this week, I am not sure to be able to sent it
before Monday.

Regards,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
