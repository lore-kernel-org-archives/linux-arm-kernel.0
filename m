From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 25 Mar 2014 12:06:09 +0000
Subject: [PATCH v9 2/5] kernel: missing include in cputime.c
In-Reply-To: <1389292336-9292-2-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1401091755390.21510@kaball.uk.xensource.com>
 <1389292336-9292-2-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <alpine.DEB.2.02.1403251204240.8273@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter,
is this patch OK for you?

On Thu, 9 Jan 2014, Stefano Stabellini wrote:
> steal_account_process_tick calls paravirt_steal_clock, but paravirt.h is
> currently missing among the included header files.
> Add include asm/paravirt.h.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: mingo at redhat.com
> CC: peterz at infradead.org
> ---
>  kernel/sched/cputime.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 9994791..951833e 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -5,6 +5,9 @@
>  #include <linux/static_key.h>
>  #include <linux/context_tracking.h>
>  #include "sched.h"
> +#ifdef CONFIG_PARAVIRT
> +#include <asm/paravirt.h>
> +#endif
>  
>  
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
> -- 
> 1.7.10.4
> 
