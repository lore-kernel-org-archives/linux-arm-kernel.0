From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 24 Aug 2015 10:00:43 +0200
Subject: [PATCH 0/2] arm64: ignore memory outside of the linear range
In-Reply-To: <CY1PR0301MB0748FC71E6866C8AFACAAFF687780@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <1439890482-20798-1-git-send-email-ard.biesheuvel@linaro.org>
 <CY1PR0301MB0748FC71E6866C8AFACAAFF687780@CY1PR0301MB0748.namprd03.prod.outlook.com>
Message-ID: <CAKv+Gu-OQ4VyCqe=mEDOrrfAtAWTfRtAiqXMGSVjJxOH6xi4Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 August 2015 at 16:18, Stuart Yoder <stuart.yoder@freescale.com> wrote:
>
>
>> -----Original Message-----
>> From: Ard Biesheuvel [mailto:ard.biesheuvel at linaro.org]
>> Sent: Tuesday, August 18, 2015 4:35 AM
>> To: linux-arm-kernel at lists.infradead.org; mark.rutland at arm.com; catalin.marinas at arm.com; robh at kernel.org
>> Cc: grant.likely at linaro.org; Yoder Stuart-B08248; will.deacon at arm.com; Ard Biesheuvel
>> Subject: [PATCH 0/2] arm64: ignore memory outside of the linear range
>>
>> This is a followup to the single patch I posted on Aug 15th to ignore
>> RAM that cannot be covered by the linear mapping. Instead of clipping
>> the memory after the fact, this clips the memory before installing the
>> regions into the memblock memory table.
>>
>> This is basically the approach that Mark Rutland suggested here
>>
>> http://article.gmane.org/gmane.linux.ports.arm.kernel/430239
>>
>> but modified to correctly consider the base of the kernel image as the
>> start of the linear mapping.
>>
>> Ard Biesheuvel (2):
>>   of/fdt: make memblock maximum physical address arch configurable
>>   arm64: set MAX_MEMBLOCK_ADDR according to linear region size
>>
>>  arch/arm64/include/asm/memory.h |  8 ++++++++
>>  drivers/of/fdt.c                | 12 +++++++-----
>>  2 files changed, 15 insertions(+), 5 deletions(-)
>
> Tested on Freescale LS2085ARDB which has a split memory region
> that triggers the bug.
>
> Tested-by: Stuart Yoder <stuart.yoder@freescale.com>
>

Hi Will,

Will you be picking up this series for v4.3? If so, do you need me to
resend it with the tags added?

Thanks,
Ard.
