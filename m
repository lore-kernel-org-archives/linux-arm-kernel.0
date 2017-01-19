From: fu.wei@linaro.org (Fu Wei)
Date: Thu, 19 Jan 2017 17:47:14 +0800
Subject: [PATCH v20 11/17] clocksource/drivers/arm_arch_timer: Introduce
 some new structs to prepare for GTDT
In-Reply-To: <a47f2474-fb29-9217-3de1-6e2a6a36f21f@linaro.org>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-12-fu.wei@linaro.org>
 <a47f2474-fb29-9217-3de1-6e2a6a36f21f@linaro.org>
Message-ID: <CADyBb7uhwU_ACGQRvw8zPg-VCdxyO2L1MEoeZWS1zYdveLK6PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanjun,

On 19 January 2017 at 16:28, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> On 2017/1/18 21:25, fu.wei at linaro.org wrote:
>>
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> The patch introduce two new structs: arch_timer_mem, arch_timer_mem_frame.
>> And also introduce a new define: ARCH_TIMER_MEM_MAX_FRAMES
>>
>> These will be used for refactoring the memory-mapped timer init code to
>> prepare for GTDT
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>>  include/clocksource/arm_arch_timer.h | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/include/clocksource/arm_arch_timer.h
>> b/include/clocksource/arm_arch_timer.h
>> index 4a98c06..b7dd185 100644
>> --- a/include/clocksource/arm_arch_timer.h
>> +++ b/include/clocksource/arm_arch_timer.h
>> @@ -57,6 +57,8 @@ enum arch_timer_spi_nr {
>>  #define ARCH_TIMER_MEM_PHYS_ACCESS     2
>>  #define ARCH_TIMER_MEM_VIRT_ACCESS     3
>>
>> +#define ARCH_TIMER_MEM_MAX_FRAMES      8
>> +
>>  #define ARCH_TIMER_USR_PCT_ACCESS_EN   (1 << 0) /* physical counter */
>>  #define ARCH_TIMER_USR_VCT_ACCESS_EN   (1 << 1) /* virtual counter */
>>  #define ARCH_TIMER_VIRT_EVT_EN         (1 << 2)
>> @@ -72,6 +74,21 @@ struct arch_timer_kvm_info {
>>         int virtual_irq;
>>  };
>>
>> +struct arch_timer_mem_frame {
>> +       int frame_nr;
>> +       phys_addr_t cntbase;
>> +       size_t size;
>> +       int phys_irq;
>> +       int virt_irq;
>> +};
>> +
>> +struct arch_timer_mem {
>> +       phys_addr_t cntctlbase;
>> +       size_t size;
>> +       int num_frames;
>> +       struct arch_timer_mem_frame frame[ARCH_TIMER_MEM_MAX_FRAMES];
>> +};
>
>
> Since struct is introduced but not used in this patch, how about
> squash it with patch 12/17?

In the previous patchset, I have been suggested that I should split it out.

>
> Thanks
> Hanjun



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
