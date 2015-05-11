From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 11 May 2015 15:19:00 +0100
Subject: [PATCH] arm-cci: Do not enable CCI-400 PMU by default
In-Reply-To: <20150511140736.GF2067@n2100.arm.linux.org.uk>
References: <1431348626-2767-1-git-send-email-suzuki.poulose@arm.com>
 <20150511140736.GF2067@n2100.arm.linux.org.uk>
Message-ID: <5550BA54.4020302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/15 15:07, Russell King - ARM Linux wrote:
> On Mon, May 11, 2015 at 01:50:26PM +0100, Suzuki K. Poulose wrote:
>>   config ARM_CCI400_PMU
>>   	bool "ARM CCI400 PMU support"
>> -	default y
>>   	depends on ARM || ARM64
>> -	depends on HW_PERF_EVENTS
>> +	depends on PERF_EVENTS
>>   	select ARM_CCI400_COMMON
>>   	help
>> -	  Support for PMU events monitoring on the ARM CCI cache coherent
>> -	  interconnect.
>> -
>> -	  If unsure, say Y
>> +	  Support for PMU events monitoring on the ARM CCI-400 (cache coherent
>> +	  interconnect). CCI-400 supports counting events related to the
>> +	  connected slave/master interfaces.
>
> This still needs to be better.  How do I know whether it should be enabled
> for my platform or not?
>
> Presumably, we can say that CCI-400 does not appear on CPUs older than X,
> which means we can add "The CCI-400 may be provided on ARM CPUs X or
> later."
>
> I doubt that you'll find CCI-400 on ARMv6 or older ARM architectures for
> example.  Maybe then we need "depends on ARM || ARM64" to be tighter?
> "depends on (ARM && CPU_V7) || ARM64" ?
>
Yes, the CCI-400 could be found only on V7 or later (which could include 
32bit only V8) for ARM32.

I can fix that.

Suzuki
