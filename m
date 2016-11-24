From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 24 Nov 2016 17:33:33 +0000
Subject: [RFC PATCH 11/11] ARM: Allow ARCH_MULTIPLATFORM to be selected
 for NOMMU
In-Reply-To: <20161124172826.GB3524@afzalpc>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-12-git-send-email-vladimir.murzin@arm.com>
 <16587553.f9R1mxJih5@wuerfel> <583478FB.4020008@arm.com>
 <20161123154829.GA2489@afzalpc> <5835BEBA.8050905@arm.com>
 <20161124172826.GB3524@afzalpc>
Message-ID: <5837246D.5080106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/11/16 17:28, Afzal Mohammed wrote:
> Hi,
> 
> On Wed, Nov 23, 2016 at 04:07:22PM +0000, Vladimir Murzin wrote:
> 
>> I think this one is fixed by
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 8e7496c..c3349b9 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -2019,7 +2019,7 @@ config XIP_PHYS_ADDR
>>  config KEXEC
>>         bool "Kexec system call (EXPERIMENTAL)"
>>         depends on (!SMP || PM_SLEEP_SMP)
>> -       depends on !CPU_V7M
>> +       depends on MMU
> 
>> These we fixed in 9001214 ("ARM: imx: no need to select SMP_ON_UP explicitly")
> 
>> Thanks for trying it. Just a gentle remainder not to forget to set DRAM_BASE
>> and DRAM_SIZE ;)
> 
> Thanks for the info.
> 
> Based on your feedback, have been able to build multi_v7 w/ MMU & SMP
> disabled.
> 
> Trying to get something in the console on Cortex A platform.

Make sure you have ARM_MPU disabled, otherwise it will die early (I keep
proper patch for that here).

Cheers
Vladimir

> 
> Regards
> afzal
> 
