From: vkale@apm.com (Vinayak Kale)
Date: Fri, 21 Jun 2013 16:13:59 +0530
Subject: [PATCH V3 1/4] arm64: Add Kconfig option for APM X-Gene SOC family
In-Reply-To: <20130621093656.GB4099@arm.com>
References: <1366794420-17849-1-git-send-email-vkale@apm.com>
 <1366794420-17849-2-git-send-email-vkale@apm.com>
 <20130621093656.GB4099@arm.com>
Message-ID: <CAPrCYkc-=-no+TpHb8XMQYFoyqCJoXe9RR1-jazxCCNeFQ12Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Fri, Jun 21, 2013 at 3:06 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> Hi Vinayak,
>
> On Wed, Apr 24, 2013 at 10:06:57AM +0100, Vinayak Kale wrote:
>> This patch adds arm64/Kconfig option for APM X-Gene SOC family.
>>
>> Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
>> Signed-off-by: Loc Ho <lho@apm.com>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> ---
>>  arch/arm64/Kconfig |    7 +++++++
>>  1 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 43b0e9f..16d0198 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -114,6 +114,11 @@ config ARCH_VEXPRESS
>>         This enables support for the ARMv8 software model (Versatile
>>         Express).
>>
>> +config ARCH_XGENE
>> +     bool "AppliedMicro X-Gene SOC Family"
>> +     help
>> +       This enables support for AppliedMicro X-Gene SOC Family
>> +
>>  endmenu
>>
>>  menu "Bus support"
>> @@ -153,6 +158,8 @@ config NR_CPUS
>>       int "Maximum number of CPUs (2-32)"
>>       range 2 32
>>       depends on SMP
>> +     # These have to remain sorted largest to smallest
>> +     default "8" if ARCH_XGENE
>>       default "4"
>
> For ARCH_VEXPRESS I was planning to get rid of the Kconfig entry and
> just select the drivers in the defconfig file (once some other patches
> get merged). Do you have any dependencies on ARCH_XGENE apart from
> what's here?
>

Apart from here, we do have dependency on ARCH_XGENE:
1) To select XGENE SoC specific dtb compilation
2) Use this to forcefully select certain platform drivers such as Clock.

> --
> Catalin

-Vinayak
