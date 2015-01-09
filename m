From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 9 Jan 2015 10:28:47 +0800
Subject: [PATCH v19 01/11] ARM: probes: move all probe code to dedicate
 directory
In-Reply-To: <1420457350-77053-1-git-send-email-wangnan0@huawei.com>
References: <1420457284-76923-1-git-send-email-wangnan0@huawei.com>
 <1420457350-77053-1-git-send-email-wangnan0@huawei.com>
Message-ID: <54AF3CDF.9000004@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/1/5 19:29, Wang Nan wrote:
> In discussion on LKML (https://lkml.org/lkml/2014/11/28/158), Russell
> King suggests to move all probe related code to arch/arm/probes. This
> patch does the work. Due to dependency on 'arch/arm/kernel/patch.h', this
> patch also moves patch.h to 'arch/arm/include/asm/patch.h', and related
> '#include' directives are also midified to '#include <asm/patch.h>'.
> 
> Following is an overview of this patch:
> 
>  ./arch/arm/kernel/               ./arch/arm/probes/
>  |-- Makefile                     |-- Makefile
>  |-- probes-arm.c          ==>    |-- decode-arm.c
>  |-- probes-arm.h          ==>    |-- decode-arm.h
>  |-- probes-thumb.c        ==>    |-- decode-thumb.c
>  |-- probes-thumb.h        ==>    |-- decode-thumb.h
>  |-- probes.c              ==>    |-- decode.c
>  |-- probes.h              ==>    |-- decode.h
>  |                                |-- kprobes
>  |                                |   |-- Makefile
>  |-- kprobes-arm.c         ==>    |   |-- actions-arm.c
>  |-- kprobes-common.c      ==>    |   |-- actions-common.c
>  |-- kprobes-thumb.c       ==>    |   |-- actions-thumb.c
>  |-- kprobes.c             ==>    |   |-- core.c
>  |-- kprobes.h             ==>    |   |-- core.h
>  |-- kprobes-test-arm.c    ==>    |   |-- test-arm.c
>  |-- kprobes-test.c        ==>    |   |-- test-core.c
>  |-- kprobes-test.h        ==>    |   |-- test-core.h
>  |-- kprobes-test-thumb.c  ==>    |   `-- test-thumb.c
>  |                                `-- uprobes
>  |                                    |-- Makefile
>  |-- uprobes-arm.c         ==>        |-- actions-arm.c
>  |-- uprobes.c             ==>        |-- core.c
>  |-- uprobes.h             ==>        `-- core.h
>  |
>  `-- patch.h               ==>    arch/arm/include/asm/patch.h
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Acked-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Hi,

Thanks to Tixy and his test robot, a bug is found in this patch: I forgot to change
arch/arm/kernel/kgdb.c, which also includes patch.h. A small code modification
is required.

I have posted a new version of this patch by replying.

Tixy, could you please collect it into your git repository and help me test it
again?

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/314520.html

Thanks.
