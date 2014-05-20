From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 20 May 2014 19:53:07 +0800
Subject: [PATCH 17/20] ARM: imx5: move init hooks into mach-imx5x.c
In-Reply-To: <1400575538-21136-18-git-send-email-shawn.guo@freescale.com>
References: <1400575538-21136-1-git-send-email-shawn.guo@freescale.com>
 <1400575538-21136-18-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140520115306.GC20778@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 04:45:35PM +0800, Shawn Guo wrote:
> @@ -24,6 +24,12 @@
>  #include "hardware.h"
>  #include "mx53.h"
>  
> +static void __init imx53_init_early(void)
> +{
> +	mxc_set_cpu_type(MXC_CPU_MX53);
> +	imx_src_init();

This imx_src_init() call should be moved into imx53_dt_init() like what
we did for imx51.

Shawn

> +}
> +
>  static void __init imx53_dt_init(void)
>  {
>  	mxc_arch_reset_init_dt();
