From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Jan 2013 13:31:06 +0800
Subject: [PATCH 3/7] ARM i.MX6q: Add GPU, VPU, IPU, and OpenVG resets to
 System Reset Controller (SRC)
In-Reply-To: <1358352787-15441-4-git-send-email-p.zabel@pengutronix.de>
References: <1358352787-15441-1-git-send-email-p.zabel@pengutronix.de>
 <1358352787-15441-4-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130117053104.GI26179@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 05:13:03PM +0100, Philipp Zabel wrote:
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/smp.h>
> +#include <linux/reset-controller.h>

Move it one line above to have it sorted.

>  #include <asm/smp_plat.h>

...

> --- /dev/null
> +++ b/include/linux/imx-src.h
> @@ -0,0 +1,6 @@
> +#ifndef __IMX_SRC_H__
> +#define __IMX_SRC_H__
> +
> +extern int imx_src_reset(int sw_reset_idx);
> +
> +#endif /* __IMX_SRC_H__ */

This is header is not needed any more.

Shawn
