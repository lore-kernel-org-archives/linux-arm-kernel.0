From: patrice.chotard@st.com (Patrice Chotard)
Date: Wed, 2 Nov 2016 14:22:17 +0100
Subject: [PATCH 3/5] ARM: multi_v7_defconfig: Remove
 CONFIG_ST_THERMAL_MEMMAP Kconfig symbol
In-Reply-To: <20161024101408.GA10440@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1477065443-10668-1-git-send-email-patrice.chotard@st.com>
 <1477065443-10668-4-git-send-email-patrice.chotard@st.com>
 <20161024101408.GA10440@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <4e1a0a27-d50e-b577-f617-025d55588157@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/24/2016 12:14 PM, Peter Griffin wrote:
> Hi Patrice,
> 
> On Fri, 21 Oct 2016, patrice.chotard at st.com wrote:
> 
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> Driver code has been already removed, see
>> http://www.spinics.net/lists/devicetree/msg143322.html
>> Remove the multi_v7_defconfig part
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>> Cc: <rui.zhang@intel.com>
>> Cc: <edubezval@gmail.com>
>> ---
>>  arch/arm/configs/multi_v7_defconfig | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 15b2f99..45e252b 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -450,7 +450,6 @@ CONFIG_RCAR_THERMAL=y
>>  CONFIG_ARMADA_THERMAL=y
>>  CONFIG_DAVINCI_WATCHDOG=m
>>  CONFIG_EXYNOS_THERMAL=m
>> -CONFIG_ST_THERMAL_MEMMAP=y
> 

Hi Peter

> Are you sure you want to remove this?

Well spotted, you are right. It must be kept.

Thanks

> 
> This Kconfig symbol is still used for the stih407 family
> thermal parts in drivers/thermal/st/st_thermal_memmap.c?
> 
> My patch only removed the stih415/6 parts from the driver.
> 
> regards,
> 
> Peter.
> 
