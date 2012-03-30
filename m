From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Fri, 30 Mar 2012 18:06:07 -0400
Subject: [PATCH] ARM: include linux/bug.h in insn.c
In-Reply-To: <1333142002-15431-1-git-send-email-joachim.eastwood@jotron.com>
References: <1333142002-15431-1-git-send-email-joachim.eastwood@jotron.com>
Message-ID: <CAP=VYLp173qpMwrLDRuvNURjJ6+TvkP7dHb6vDWgELiz9T9kGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 5:13 PM, Joachim Eastwood <manabian@gmail.com> wrote:
> After commit d82227cf8 building the kernel fails with:

Please also list the shortlog when giving a commit ID, i.e.

   "ARM: 7331/1: extract out insn generation code from ftrace"

Thanks,
Paul.

> ?arch/arm/kernel/insn.c: In function '__arm_gen_branch_thumb2':
> ?arch/arm/kernel/insn.c:13: error: implicit declaration of function 'WARN_ON_ONCE'
> ?make[1]: *** [arch/arm/kernel/insn.o] Error 1
> ?make: *** [arch/arm/kernel] Error 2
>
> insn.c uses WARN_ON_ONCE so lets include bug.h.
>
> Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
> ---
> ?arch/arm/kernel/insn.c | ? ?1 +
> ?1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/kernel/insn.c b/arch/arm/kernel/insn.c
> index ab312e5..080fc70 100644
> --- a/arch/arm/kernel/insn.c
> +++ b/arch/arm/kernel/insn.c
> @@ -1,4 +1,5 @@
> ?#include <linux/kernel.h>
> +#include <linux/bug.h>
> ?#include <asm/opcodes.h>
>
> ?static unsigned long
> --
> 1.7.9.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
