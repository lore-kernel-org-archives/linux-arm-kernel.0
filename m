From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 27 Feb 2018 18:11:25 +0100
Subject: [PATCH 2/3] ARM: configs: stm32: Enable ARM_MPU
In-Reply-To: <5d8f2c2f-ca2e-632e-bac6-29299dda724e@arm.com>
References: <1513101746-18030-1-git-send-email-alexandre.torgue@st.com>
 <1513101746-18030-3-git-send-email-alexandre.torgue@st.com>
 <5d8f2c2f-ca2e-632e-bac6-29299dda724e@arm.com>
Message-ID: <64b2e6b6-4d91-5dd7-be10-276f0b9d0ea3@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vlad

On 12/13/2017 11:11 AM, Vladimir Murzin wrote:
> On 12/12/17 18:02, Alexandre Torgue wrote:
>> STM32 MCUs embed a Memory Protection Unit. Enabling this setting will
>> allow the Kernel to configure the MPU according to devicetree.
> 
> Would it be better to "select ARM_MPU" for machines with Cortex-M7?

Sorry for this late answer. You are right I will use a "select" only for 
stm32f7 and stm32h7 machines in mach-stm32/Kconfig.

Regards
Alex

> 
> Vladimir
> 
>>
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
>>
>> diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
>> index bb358ff..e642bdf9 100644
>> --- a/arch/arm/configs/stm32_defconfig
>> +++ b/arch/arm/configs/stm32_defconfig
>> @@ -24,6 +24,7 @@ CONFIG_SET_MEM_PARAM=y
>>   CONFIG_DRAM_BASE=0x90000000
>>   CONFIG_FLASH_MEM_BASE=0x08000000
>>   CONFIG_FLASH_SIZE=0x00200000
>> +CONFIG_ARM_MPU=y
>>   CONFIG_PREEMPT=y
>>   # CONFIG_ATAGS is not set
>>   CONFIG_ZBOOT_ROM_TEXT=0x0
>>
> 
