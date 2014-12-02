From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Tue, 02 Dec 2014 13:59:07 +0900
Subject: [PATCH v11 1/7] ARM: probes: move all probe code to dedicate
 directory
In-Reply-To: <1417423695-47521-1-git-send-email-wangnan0@huawei.com>
References: <1417423513-47161-1-git-send-email-wangnan0@huawei.com>
 <1417423695-47521-1-git-send-email-wangnan0@huawei.com>
Message-ID: <547D471B.2070908@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2014/12/01 17:48), Wang Nan wrote:
> In discussion on LKML (https://lkml.org/lkml/2014/11/28/158), Russell
> King suggest to move all probe related code to arch/arm/probes. This
> patch do the work. Due to dependency on 'arch/arm/kernel/patch.h', this
> patch also move patch.h to 'arch/arm/include/asm/patch.h', and related
> '#include' directive are also midified to '#include <asm/patch.h>'.

Moving is good to me, but renaming files are also required I think.

> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> ---
>  arch/arm/Makefile                                |  1 +
>  arch/arm/{kernel => include/asm}/patch.h         |  0
>  arch/arm/kernel/Makefile                         | 16 ++--------------
>  arch/arm/kernel/jump_label.c                     |  2 +-
>  arch/arm/kernel/patch.c                          |  3 +--
>  arch/arm/probes/Makefile                         | 15 +++++++++++++++
>  arch/arm/{kernel => probes}/kprobes-arm.c        |  0
>  arch/arm/{kernel => probes}/kprobes-common.c     |  0
>  arch/arm/{kernel => probes}/kprobes-test-arm.c   |  0
>  arch/arm/{kernel => probes}/kprobes-test-thumb.c |  0
>  arch/arm/{kernel => probes}/kprobes-test.c       |  0
>  arch/arm/{kernel => probes}/kprobes-test.h       |  0
>  arch/arm/{kernel => probes}/kprobes-thumb.c      |  0
>  arch/arm/{kernel => probes}/kprobes.c            |  2 +-
>  arch/arm/{kernel => probes}/kprobes.h            |  0
>  arch/arm/{kernel => probes}/probes-arm.c         |  0
>  arch/arm/{kernel => probes}/probes-arm.h         |  0
>  arch/arm/{kernel => probes}/probes-thumb.c       |  0
>  arch/arm/{kernel => probes}/probes-thumb.h       |  0
>  arch/arm/{kernel => probes}/probes.c             |  0
>  arch/arm/{kernel => probes}/probes.h             |  0
>  arch/arm/{kernel => probes}/uprobes-arm.c        |  0
>  arch/arm/{kernel => probes}/uprobes.c            |  0
>  arch/arm/{kernel => probes}/uprobes.h            |  0

As I did on x86, these would be better renamed as expressing what they do.
I guess most of the files may have emulate-*.c or decode-*.c :)

Thank you,



-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
