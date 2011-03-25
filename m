From: nleeder@codeaurora.org (Neil Leeder)
Date: Fri, 25 Mar 2011 14:21:10 -0400
Subject: [PATCH v4 2/3] [ARM] perfevents: Add support for Scorpion
	performance monitors
In-Reply-To: <AANLkTikodmNmqFPBF1mO9Gsi0r01e0C-+jV=qT34=pqr@mail.gmail.com>
References: <1299608733-28514-1-git-send-email-sheetals@codeaurora.org>	<1299691007-13470-1-git-send-email-sheetals@codeaurora.org>	<4D7EC274.4020407@codeaurora.org>	<cabe5c85f32b7eb41504225acfcc87df.squirrel@www.codeaurora.org>
	<AANLkTikodmNmqFPBF1mO9Gsi0r01e0C-+jV=qT34=pqr@mail.gmail.com>
Message-ID: <4D8CDD16.9060102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 3/16/2011 5:13 AM, Jean Pihet wrote:
> On Tue, Mar 15, 2011 at 4:58 PM, Sheetal Sahasrabudhe
> <sheetals@codeaurora.org>  wrote:
>> Hi Will/Jean,
>>
>> On Mon, March 14, 2011 6:35 pm, Bryan Huntsman wrote:
>>> On 03/09/2011 09:16 AM, Sheetal Sahasrabudhe wrote:
>>>> This commit adds support for performance monitors provided by
>>>> Qualcomm Scorpion and ScorpionMP processor to perfevents.
>>>>
>>>> Signed-off-by: Sheetal Sahasrabudhe<sheetals@codeaurora.org>
>>>> Reviewed-by: Jean Pihet<j-pihet@ti.com>
>>>> Reviewed-by: Will Deacon<will.deacon@arm.com>
>>>> ---
>>>>   arch/arm/include/asm/perf_event.h |    2 +
>>>>   arch/arm/kernel/perf_event.c      |   11 +
>>>>   arch/arm/kernel/perf_event_msm.c  |  679 +++++++++++++++++++++++++++++++++++++
>>>>   3 files changed, 692 insertions(+), 0 deletions(-)
>>>>   create mode 100644 arch/arm/kernel/perf_event_msm.c
>>>>
>>>
>>> ...
>>>
>>>> diff --git a/arch/arm/kernel/perf_event_msm.c b/arch/arm/kernel/perf_event_msm.c
>>>> new file mode 100644
>>>> index 0000000..4e42f27
>>>> --- /dev/null
>>>> +++ b/arch/arm/kernel/perf_event_msm.c
>> [...]
>>
>>>> +#include<asm/vfp.h>
>>>> +#include<asm/system.h>
>>>> +#include "../vfp/vfpinstr.h"
>>>
>>> Sorry I didn't see this earlier.  Is there another way to get the info
>>> you need that wouldn't use a relative include path?  If the info from
>>> vfpinstr.h is now needed outside of the vfp directory, can it be moved
>>> to a common header instead?  Thanks.
> Good catch! Sorry I did not catch this one while reviewing the code.
>
>>>
>>> - Bryan
>>
>> I see other files under vfp that include this header.
>> So if we were to implement Bryan's suggestion, I think a separate patch that moves the header and updates all the depdendencies would be more appropriate.
>> Are you okay with the relative include path for vfpinstr.h in this patch for now or would you want to see an update to move vfpinstr.h to include/asm?.
>
> Adding Russell and Nicolas for the VFP question.
> Only fmrx and fmxr are used from "../vfp/vfpinstr.h". Can those be
> moved to arch/arm/include/asm/vfp.h?
>
> What is the best solution to this?
>
> Regards,
> Jean
>

Any opinions on what would be the best thing to do here? Choices appear to be:

1) allow the relative include path of ../vfp/vfpinstr.h
2) move the definitions of fmrx, fmxr from vfp/vfpinstr.h to include/asm/vfp.h
3) move vfp/vfpinstr.h to include/asm
4) other...?

If it helps, I can create a patch for whichever is considered the preferred solution.

Thanks,
Neil (Standing in temporarily for Sheetal while she is on leave of absence)

>>
>> Thanks,
>> Sheetal
>>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum
