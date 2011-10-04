From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 04 Oct 2011 14:48:08 +0100
Subject: [PATCH v4 06/10] ARM: SoC: convert Exynos4 to SoC descriptor
In-Reply-To: <019701cc8297$c91bd9e0$5b538da0$%kim@samsung.com>
References: <1317663356-5114-1-git-send-email-marc.zyngier@arm.com>
	<1317663356-5114-7-git-send-email-marc.zyngier@arm.com>
	<019701cc8297$c91bd9e0$5b538da0$%kim@samsung.com>
Message-ID: <4E8B0E98.30306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/11 14:16, Kukjin Kim wrote:
> Marc Zyngier wrote:
>>
>> Convert Exynos4 to use the SoC descriptor to provide its SMP
>> and CPU hotplug operations.
>>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/mach-exynos4/core.h                |    9 +++++++++
>>  arch/arm/mach-exynos4/cpu.c                 |    8 ++++++++
>>  arch/arm/mach-exynos4/hotplug.c             |    8 +++++---
>>  arch/arm/mach-exynos4/mach-armlex4210.c     |    3 +++
>>  arch/arm/mach-exynos4/mach-nuri.c           |    3 +++
>>  arch/arm/mach-exynos4/mach-origen.c         |    3 +++
>>  arch/arm/mach-exynos4/mach-smdk4212.c       |    3 +++
>>  arch/arm/mach-exynos4/mach-smdkv310.c       |    4 ++++
>>  arch/arm/mach-exynos4/mach-universal_c210.c |    3 +++
>>  arch/arm/mach-exynos4/platsmp.c             |   25
>> +++++++++++++++++++++----
>>  10 files changed, 62 insertions(+), 7 deletions(-)
>>  create mode 100644 arch/arm/mach-exynos4/core.h
>>
>> diff --git a/arch/arm/mach-exynos4/core.h b/arch/arm/mach-exynos4/core.h
>> new file mode 100644
>> index 0000000..ba9fcc8
>> --- /dev/null
>> +++ b/arch/arm/mach-exynos4/core.h
> 
> Is there any reason to add core.h in mach-exynos4 not
> mach-exynos4/include/mach?

No particular reason. If you prefer having that file in include/mach,
I'll move it, though I don't think it makes much more sense.

>> +
>> +struct arm_soc_desc exynos4_soc_desc __initdata = {
>> +	.name		= "Samsung Exynos4",
> 
> If you're ok, I preferred 'Samsung EXYNOS4'

No problem.

> And could you please re-work this based on latest my for-next because there
> are updated board file.

Where is your for-next branch located these days? When it gets picked up
by linux-next, I'll update the board files. As of next-20111004, I seem
to cover them all.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
