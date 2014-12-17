From: wangnan0@huawei.com (Wang Nan)
Date: Wed, 17 Dec 2014 13:36:37 +0800
Subject: [PATCH v16 1/8] ARM: probes: move all probe code to dedicate
 directory
In-Reply-To: <548AC8BD.5090602@hitachi.com>
References: <1418292276-75255-1-git-send-email-wangnan0@huawei.com>
 <1418292276-75255-2-git-send-email-wangnan0@huawei.com>
 <548AC8BD.5090602@hitachi.com>
Message-ID: <54911665.3070601@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Could you please collect this patch and merge it into your repository first? Due
to this is a source tree layout modification, others may work on original files
and experiences unneed conflicts.

Thank you.

On 2014/12/12 18:51, Masami Hiramatsu wrote:
> (2014/12/11 19:04), Wang Nan wrote:
>> In discussion on LKML (https://lkml.org/lkml/2014/11/28/158), Russell
>> King suggests to move all probe related code to arch/arm/probes. This
>> patch does the work. Due to dependency on 'arch/arm/kernel/patch.h', this
>> patch also moves patch.h to 'arch/arm/include/asm/patch.h', and related
>> '#include' directives are also midified to '#include <asm/patch.h>'.
>>
>> Following is an overview of this patch:
>>
>>  ./arch/arm/kernel/               ./arch/arm/probes/
>>  |-- Makefile                     |-- Makefile
>>  |-- probes-arm.c          ==>    |-- decode-arm.c
>>  |-- probes-arm.h          ==>    |-- decode-arm.h
>>  |-- probes-thumb.c        ==>    |-- decode-thumb.c
>>  |-- probes-thumb.h        ==>    |-- decode-thumb.h
>>  |-- probes.c              ==>    |-- decode.c
>>  |-- probes.h              ==>    |-- decode.h
>>  |                                |-- kprobes
>>  |                                |   |-- Makefile
>>  |-- kprobes-arm.c         ==>    |   |-- actions-arm.c
>>  |-- kprobes-common.c      ==>    |   |-- actions-common.c
>>  |-- kprobes-thumb.c       ==>    |   |-- actions-thumb.c
>>  |-- kprobes.c             ==>    |   |-- core.c
>>  |-- kprobes.h             ==>    |   |-- core.h
>>  |-- kprobes-test-arm.c    ==>    |   |-- test-arm.c
>>  |-- kprobes-test.c        ==>    |   |-- test-core.c
>>  |-- kprobes-test.h        ==>    |   |-- test-core.h
>>  |-- kprobes-test-thumb.c  ==>    |   `-- test-thumb.c
>>  |                                `-- uprobes
>>  |                                    |-- Makefile
>>  |-- uprobes-arm.c         ==>        |-- actions-arm.c
>>  |-- uprobes.c             ==>        |-- core.c
>>  |-- uprobes.h             ==>        `-- core.h
>>  |
>>  `-- patch.h               ==>    arch/arm/include/asm/patch.h
>>
>> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> 
> It looks good to me :)
> 
> Acked-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> 
> Thanks!
> 
