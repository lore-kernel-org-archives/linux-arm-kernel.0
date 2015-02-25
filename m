From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 25 Feb 2015 11:39:55 +0000
Subject: [PATCH] drivers: cpuidle: Explictly include proc-fns.h for
 cpuidle-arm64
In-Reply-To: <20150225112758.GB20214@red-moon>
References: <1424827506-12245-1-git-send-email-lauraa@codeaurora.org>
 <20150225111828.GA9714@leverpostej>
 <20150225112758.GB20214@red-moon>
Message-ID: <20150225113955.GB9714@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

> Subject: [PATCH] drivers: cpuidle: cpuidle-arm64: include asm/proc-fns.h
>  explicitly
> 
> ARM64 CPUidle driver requires the cpu_do_idle function so that it can
> be used to enter the shallowest idle state, and it is declared in
> asm/proc-fns.h.
> 
> This patch adds the explicit inclusion of the asm/proc-fns.h header file
> to stop relying on implicit inclusion of the same file through implicit
> header files dependencies.

Laura's original commit message made it clear that this was a real
problem for CONFIG_ARM64_64K_PAGES=y, while this makes it sound like a
cleanup.

We should make it clear that without this the build is broken when
CONFIG_ARM64_64K_PAGES=y.

> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> [lp: rebased/rewrote commit log]
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Otherwise this applies, and seems to work:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/cpuidle/cpuidle-arm64.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
> index 39a2c62..c8bb6c5 100644
> --- a/drivers/cpuidle/cpuidle-arm64.c
> +++ b/drivers/cpuidle/cpuidle-arm64.c
> @@ -19,6 +19,7 @@
>  #include <linux/of.h>
>  
>  #include <asm/cpuidle.h>
> +#include <asm/proc-fns.h>
>  
>  #include "dt_idle_states.h"
>  
> -- 
> 2.2.1
> 
> 
