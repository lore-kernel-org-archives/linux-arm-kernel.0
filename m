From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 Apr 2012 11:02:54 -0700
Subject: [PATCH RESEND] omap1: mux: add missing include
In-Reply-To: <1333916610-7451-1-git-send-email-aaro.koskinen@iki.fi>
References: <1333916610-7451-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20120409180253.GA6487@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [120408 13:26]:
> Fix the following build breakage in v3.4-rc2:
> 
> arch/arm/mach-omap1/mux.c:89:1: error: 'FUNC_MUX_CTRL_9' undeclared here (not in a function)
> arch/arm/mach-omap1/mux.c:89:1: error: 'PULL_DWN_CTRL_2' undeclared here (not in a function)
> arch/arm/mach-omap1/mux.c:93:1: error: 'FUNC_MUX_CTRL_C' undeclared here (not in a function)
> 
> etc.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> ---
>  arch/arm/mach-omap1/mux.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
> index 087dba0..e9cc52d 100644
> --- a/arch/arm/mach-omap1/mux.c
> +++ b/arch/arm/mach-omap1/mux.c
> @@ -27,6 +27,7 @@
>  #include <linux/io.h>
>  #include <linux/spinlock.h>
>  
> +#include <mach/hardware.h>
>  
>  #include <plat/mux.h>
>  

Thanks for the repost, looks like I missed this one earlier.
Applying to fixes.

Tony
