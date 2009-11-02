From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 02 Nov 2009 09:20:51 -0800
Subject: [PATCH 33/46] davinci: add generic CPUFreq driver for DaVinci
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE1EBCEC@dbde02.ent.ti.com>
	(Sekhar Nori's message of "Mon\, 2 Nov 2009 17\:34\:05 +0530")
References: <1255720190-7452-34-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-35-git-send-email-khilman@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DE1EBCEC@dbde02.ent.ti.com>
Message-ID: <87639slu6k.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Nori, Sekhar" <nsekhar@ti.com> writes:

> On Sat, Oct 17, 2009 at 00:39:37, Kevin Hilman wrote:
>> From: Sekhar Nori <nsekhar@ti.com>
>>
>> Adds a basic CPUFreq driver for DaVinci devices registering with the
>> kernel CPUFreq infrastructure.
>>
>> Support is added for both frequency and voltage regulation.
>>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>>  arch/arm/mach-davinci/Kconfig                |    1 +
>>  arch/arm/mach-davinci/Makefile               |    3 +
>>  arch/arm/mach-davinci/cpufreq.c              |  219 ++++++++++++++++++++++++++
>>  arch/arm/mach-davinci/include/mach/cpufreq.h |   25 +++
>>  4 files changed, 248 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/mach-davinci/cpufreq.c
>>  create mode 100644 arch/arm/mach-davinci/include/mach/cpufreq.h
>>
>> diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
>> index 7b6dddf..6c81b6c 100644
>> --- a/arch/arm/mach-davinci/Kconfig
>> +++ b/arch/arm/mach-davinci/Kconfig
>> @@ -32,6 +32,7 @@ config ARCH_DAVINCI_DA830
>>          bool "DA830/OMAP-L137 based system"
>>       select CP_INTC
>>       select ARCH_DAVINCI_DA8XX
>> +     select ARCH_HAS_CPUFREQ
>
> Kevin,
>
> This config option has mistakenly been selected for DA830
> instead of DA850.
>

Thanks Sekhar,

I'll fix in davinci-next.

Kevin
