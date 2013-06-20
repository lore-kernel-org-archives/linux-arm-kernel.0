From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 20:55:42 +0200
Subject: [PATCH v3 06/10] ARM:stixxxx: Add DEBUG_LL console support
In-Reply-To: <1371737176-9473-1-git-send-email-srinivas.kandagatla@st.com>
References: <1371736996-8770-1-git-send-email-srinivas.kandagatla@st.com>
 <1371737176-9473-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <201306202055.43189.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 June 2013, Srinivas KANDAGATLA wrote:
> --- a/arch/arm/mach-stixxxx/board-dt.c
> +++ b/arch/arm/mach-stixxxx/board-dt.c
> @@ -11,6 +11,7 @@
>  #include <linux/clocksource.h>
>  #include <linux/irq.h>
>  #include <asm/hardware/cache-l2x0.h>
> +#include <asm/mach/map.h>
>  #include <asm/mach/arch.h>
>  
>  #include "smp.h"
> @@ -42,6 +43,7 @@ static const char *stih41x_dt_match[] __initdata = {
>  };
>  
>  DT_MACHINE_START(STM, "STiH415/416 SoC with Flattened Device Tree")
> +       .map_io         = debug_ll_io_init,
>         .init_time      = stih41x_timer_init,
>         .smp            = smp_ops(stixxxx_smp_ops),
>         .dt_compat      = stih41x_dt_match,

This part of the patch is no longer needed, we do the same when .map_io
is not set.

	Arnd
