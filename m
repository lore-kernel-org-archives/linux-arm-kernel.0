From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Fri, 22 Aug 2014 01:24:10 +0900
Subject: [PATCHv3] thermal: exynos: Add support for TRIM_RELOAD feature at
 Exynos3250
In-Reply-To: <53F5CACF.4050600@suse.de>
References: <1408450078-6296-1-git-send-email-cw00.choi@samsung.com>
 <1408492364-8012-1-git-send-email-cw00.choi@samsung.com>
 <CAC-25o9LjKwjBwwxcOvV75bXEHGdUh2vU=ae1STsXxD6q4YsiA@mail.gmail.com>
 <53F54D86.9070601@samsung.com> <53F5CACF.4050600@suse.de>
Message-ID: <CAGTfZH2r2hbn9d+3oENDZrSRtyHwUJXt8vjVKk0v=CKNQmLMQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andreas,

On Thu, Aug 21, 2014 at 7:32 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Hello,
>
> Am 21.08.2014 03:38, schrieb Chanwoo Choi:
>> On 08/20/2014 10:38 PM, edubezval at gmail.com wrote:
>>> On Tue, Aug 19, 2014 at 7:52 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>>> diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
>>>> index aa8e0de..8cd609c 100644
>>>> --- a/drivers/thermal/samsung/exynos_tmu_data.c
>>>> +++ b/drivers/thermal/samsung/exynos_tmu_data.c
>>>> @@ -95,6 +95,8 @@ static const struct exynos_tmu_registers exynos3250_tmu_registers = {
>>>>         .triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
>>>>         .triminfo_25_shift = EXYNOS_TRIMINFO_25_SHIFT,
>>>>         .triminfo_85_shift = EXYNOS_TRIMINFO_85_SHIFT,
>>>> +       .triminfo_ctrl[0] = EXYNOS_TMU_TRIMINFO_CON1,
>>>> +       .triminfo_ctrl[1] = EXYNOS_TMU_TRIMINFO_CON2,
>>>>         .tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
>>>>         .test_mux_addr_shift = EXYNOS4412_MUX_ADDR_SHIFT,
>>>>         .buf_vref_sel_shift = EXYNOS_TMU_REF_VOLTAGE_SHIFT,
>>>> @@ -160,8 +162,11 @@ static const struct exynos_tmu_registers exynos3250_tmu_registers = {
>>>>                 .temp_level = 95, \
>>>>         }, \
>>>>         .freq_tab_count = 2, \
>>>> +       .triminfo_reload[0] = 0x1, \
>>>> +       .triminfo_reload[1] = 0x11, \
>>>
>>> What does 0x1 mean? How about 0x11?
>>
>> The bit of 'RELOAD' field in TRIMINFO_CONTROL register is [0].
>> and The bit of 'AC Time' field in TRIMINFO_CONTROL register is [5:4].
>>
>> 0x1 means that set RELOAD field.
>> 0x11 means that set RELOAD field and ACTIME field.
>
> Might be a good idea to use #defines for 0x1 and 0x10 then?

I agree. I'm implementing it to use 'define' keyword.

Thanks,
Chanwoo Choi
