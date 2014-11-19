From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 19 Nov 2014 08:29:48 +0800
Subject: [PATCH v5 01/18] ARM64: Move the init of cpu_logical_map(0) before
 unflatten_device_tree()
In-Reply-To: <20141118170349.GU18842@arm.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-2-git-send-email-hanjun.guo@linaro.org>
 <546B4D8D.2020605@linaro.org>
 <20141118164312.GL28279@e104818-lin.cambridge.arm.com>
 <20141118165713.GT18842@arm.com> <546B7B8D.1070201@arm.com>
 <20141118170349.GU18842@arm.com>
Message-ID: <546BE47C.700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-11-19 1:03, Will Deacon wrote:
> On Tue, Nov 18, 2014 at 05:02:05PM +0000, Sudeep Holla wrote:
>> On 18/11/14 16:57, Will Deacon wrote:
>>> On Tue, Nov 18, 2014 at 04:43:13PM +0000, Catalin Marinas wrote:
>>>> On Tue, Nov 18, 2014 at 01:45:49PM +0000, Hanjun Guo wrote:
>>>>> On 2014?10?17? 21:36, Hanjun Guo wrote:
>>>>>> It always make sense to initialize CPU0's logical map entry from the
>>>>>> hardware values, so move the initialization of cpu_logical_map(0)
>>>>>> before unflatten_device_tree() which is needed by ACPI code later.
>>>>>>
>>>>>> Acked-by: Olof Johansson <olof@lixom.net>
>>>>>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>>>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>>>
>>>>> Could you merge this patch first in 3.19? It was acked by Olof and
>>>>> Mark, and it will make sense without ACPI too.
>>>>
>>>> I think it can go in for 3.19 (it's Will's turn this time ;)).
>>>
>>> This patch doesn't apply on for-next/core, as it conflicts with some of
>>> Rutland's rework ("arm64: log physical ID of boot CPU").
>>>
>>
>> It's actually not required anymore, as "arm64: log physical ID of boot
>> CPU" move it quite early in the sequence from setup_arch to
>> smp_setup_processor_id while this patch just moves it up in setup_arch.
> 
> Thanks Sudeep, I'd guessed as much :)

That's great, thanks for the reminding, I will drop this one.

Best regards
Hanjun
