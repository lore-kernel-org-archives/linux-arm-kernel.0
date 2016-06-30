From: anurupvasu@gmail.com (Anurup M)
Date: Thu, 30 Jun 2016 15:03:11 +0530
Subject: [PATCH 3/8] arm64:perf: Update Kconfig for Hisilicon PMU support
In-Reply-To: <20160628102446.GD31744@leverpostej>
References: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
 <1467107429-55477-4-git-send-email-anurup.m@huawei.com>
 <20160628102446.GD31744@leverpostej>
Message-ID: <5774E757.4050201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 28 June 2016 03:54 PM, Mark Rutland wrote:
> On Tue, Jun 28, 2016 at 05:50:24AM -0400, Anurup M wrote:
>> 	1. Update Kconfig for Hisilicon SoC ARMv8 PMU support.
>>
>> Signed-off-by: Anurup M <anurup.m@huawei.com>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> ---
>>   drivers/perf/Kconfig | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>> index 04e2653..a90b2fc 100644
>> --- a/drivers/perf/Kconfig
>> +++ b/drivers/perf/Kconfig
>> @@ -12,4 +12,13 @@ config ARM_PMU
>>   	  Say y if you want to use CPU performance monitors on ARM-based
>>   	  systems.
>>   
>> +config HISI_PERFCTR
>> +	bool "Enable hardware event counter support for HiSilicon SoC"
>> +	depends on HW_PERF_EVENTS && ARM64
>> +	select HISI_DJTAG
> This Kconfig symbol doesn't exist.
>
> You need to post the relevant code, or at the very least refer to it.
>
> This cannot be reviewed or merged in the absence of that code.
Sorry for this. We shall post the djtag driver patch for review next week.

Thanks,
Anurup
>
> Thanks,
> Mark.
>
>> +	default n
>> +	help
>> +	  Enable hardware event counter support for hardware event counters
>> +	  in Hisilicon Hi161x SoC. The hardware modules like LLC, MN1 and
>> +	  DDRC have hardware events and counters.
>>   endmenu
>> -- 
>> 2.1.4
>>
