From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 22 Apr 2016 16:15:03 +0200
Subject: [PATCH 0/3] arm64 pt dumper changes
In-Reply-To: <20160422141154.GN2998@e104818-lin.cambridge.arm.com>
References: <1456135239-3607-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160422141154.GN2998@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu-vvVp=5J5W=o9rspWGAGujm23mtMXiXbMGpm0svUds7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 April 2016 at 16:11, Catalin Marinas <catalin.marinas@arm.com> wrote:
> Hi Ard,
>
> On Mon, Feb 22, 2016 at 11:00:36AM +0100, Ard Biesheuvel wrote:
>> This series updates the kernel page table dumper to:
>> - not initialize the vmemmap region markers dynamically
>> - show region boundaries for the kasan shadow region
>> - include the UEFI runtime services mappings
>>
>> Ard Biesheuvel (3):
>>   arm64: ptdump: use static initializers for vmemmap region boundaries
>>   arm64: ptdump: add region marker for kasan shadow region
>>   arm64: ptdump: include UEFI runtime service mappings
>>
>>  arch/arm64/mm/dump.c               | 58 ++++++++------------
>>  drivers/firmware/efi/arm-runtime.c |  2 +-
>>  2 files changed, 24 insertions(+), 36 deletions(-)
>
> What's the plan with these patches? They no longer apply cleanly on top
> of arm64 for-next/core.
>

I will respin #1 and #2. Regarding patch #3, I think Mark wanted a
more flexible approach?
