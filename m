From: patrice.chotard@st.com (Patrice Chotard)
Date: Thu, 27 Feb 2014 13:27:17 +0100
Subject: [PATCH 1/4] ARM: STi: add stid127 soc support
In-Reply-To: <530F2E26.1040304@st.com>
References: <1391093744-19905-1-git-send-email-patrice.chotard@st.com>
 <1391093744-19905-2-git-send-email-patrice.chotard@st.com>
 <530F2E26.1040304@st.com>
Message-ID: <530F2F25.7000801@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime

Thanks for reviewing.
Yes for sure, i will add additional board informations.

Patrice

On 02/27/2014 01:23 PM, Maxime Coquelin wrote:
> Hi Patrice,
>
> Could you add an overview documentation as it has been done for other 
> STi platforms?
>
> See Documentation/arm/sti/stih416-overview.txt
>
> Thanks,
> Maxime
>
> On 01/30/2014 03:55 PM, Patrice CHOTARD wrote:
>> From: Alexandre TORGUE <alexandre.torgue@st.com>
>>
>> This patch adds support to STiD127 SoC.
>> The main adaptation is the L2 cache way size compare to STiH41x SoCs.
>>
>> Signed-off-by: alexandre torgue <alexandre.torgue@st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>> ---
>>   arch/arm/mach-sti/board-dt.c |    6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
>> index 1217fb5..be018a9 100644
>> --- a/arch/arm/mach-sti/board-dt.c
>> +++ b/arch/arm/mach-sti/board-dt.c
>> @@ -9,6 +9,7 @@
>>
>>   #include <linux/irq.h>
>>   #include <linux/of_platform.h>
>> +#include <linux/of.h>
>>   #include <asm/hardware/cache-l2x0.h>
>>   #include <asm/mach/arch.h>
>>
>> @@ -18,6 +19,10 @@ void __init stih41x_l2x0_init(void)
>>   {
>>       u32 way_size = 0x4;
>>       u32 aux_ctrl;
>> +
>> +    if (of_machine_is_compatible("st,stid127"))
>> +        way_size = 0x3;
>> +
>>       /* may be this can be encoded in macros like BIT*() */
>>       aux_ctrl = (0x1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT) |
>>           (0x1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
>> @@ -36,6 +41,7 @@ static void __init stih41x_machine_init(void)
>>   static const char *stih41x_dt_match[] __initdata = {
>>       "st,stih415",
>>       "st,stih416",
>> +    "st,stid127",
>>       NULL
>>   };
>>
>>
