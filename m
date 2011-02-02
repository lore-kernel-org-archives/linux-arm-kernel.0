From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 2 Feb 2011 10:24:09 +0100
Subject: [PATCH 2/6] omap4: prcm: Fix the CPUx clockdomain offsets
In-Reply-To: <87ipx3mduj.fsf@ti.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>	<1296212688-21951-3-git-send-email-santosh.shilimkar@ti.com>
	<87ipx3mduj.fsf@ti.com>
Message-ID: <4D4922B9.30501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/2/2011 2:20 AM, Hilman, Kevin wrote:
> Santosh Shilimkar<santosh.shilimkar@ti.com>  writes:
>
>> CPU0 and CPU1 clockdomain is at the offset of 0x18 from the LPRM base.
>> The header file has set it wrongly to 0x0. Offset 0x0 is for CPUx power
>> domain control register
>>
>> Fix the same.
>
> Has this also been updated in the autogen scripts?
>
> Benoit?

No, I didn't see any patch to update that yet.

Santosh or Rajendra,
Did you already fix it?

Benoit

>
> Kevin
>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> ---
>>   arch/arm/mach-omap2/prcm_mpu44xx.h |    4 ++--
>>   1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/prcm_mpu44xx.h b/arch/arm/mach-omap2/prcm_mpu44xx.h
>> index 729a644..3300ff6 100644
>> --- a/arch/arm/mach-omap2/prcm_mpu44xx.h
>> +++ b/arch/arm/mach-omap2/prcm_mpu44xx.h
>> @@ -38,8 +38,8 @@
>>   #define OMAP4430_PRCM_MPU_CPU1_INST		0x0800
>>
>>   /* PRCM_MPU clockdomain register offsets (from instance start) */
>> -#define OMAP4430_PRCM_MPU_CPU0_MPU_CDOFFS	0x0000
>> -#define OMAP4430_PRCM_MPU_CPU1_MPU_CDOFFS	0x0000
>> +#define OMAP4430_PRCM_MPU_CPU0_MPU_CDOFFS	0x0018
>> +#define OMAP4430_PRCM_MPU_CPU1_MPU_CDOFFS	0x0018
>>
>>
>>   /*
