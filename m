From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 04 Mar 2013 18:55:01 -0800
Subject: [PATCH] ARM: perf: Fix section mismatch on armpmu_init()
In-Reply-To: <20130305024338.GA17735@mudshark.cambridge.arm.com>
References: <1362438937-28143-1-git-send-email-sboyd@codeaurora.org>
 <20130305024338.GA17735@mudshark.cambridge.arm.com>
Message-ID: <51355E85.7010804@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/13 18:43, Will Deacon wrote:
> On Mon, Mar 04, 2013 at 11:15:37PM +0000, Stephen Boyd wrote:
>> WARNING: vmlinux.o(.text+0xfb80): Section mismatch in reference
>> from the function armpmu_register() to the function
>> .init.text:armpmu_init()
>> The function armpmu_register() references
>> the function __init armpmu_init().
>> This is often because armpmu_register lacks a __init
>> annotation or the annotation of armpmu_init is wrong.
>>
>> Just drop the __init marking on armpmu_init() because
>> armpmu_register() no longer has an __init marking.
>>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Cheers Stephen:
>
>   Acked-by: Will Deacon <will.deacon@arm.com>
>
> Can you put this into the patch system please?
>
>

Thanks.  7667/1

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
