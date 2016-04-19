From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 19 Apr 2016 13:20:51 +0100
Subject: [PATCH V2 05/15] coresight: tmc: splitting driver in ETB/ETF and
 ETR components
In-Reply-To: <1460483692-25061-6-git-send-email-mathieu.poirier@linaro.org>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-6-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <571622A3.4020103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/16 18:54, Mathieu Poirier wrote:
> The TMC block can operate in 3 modes (ETB, ETF and ETR) and accessed
> via two interfaces (sysFS and Perf).  That makes 6 mode to cover, which
> is way too much coupling for a single file.
>
> This patch splits the original TMC driver in 2 halves, one for ETB/ETF
> and another one for ETR mode.  A common core is kept for functionality
> common to all 3 modes.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>


> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 2d7d52747b4e..b99d4dfc1d0b 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -18,6 +18,8 @@
>   #ifndef _CORESIGHT_TMC_H
>   #define _CORESIGHT_TMC_H
>
> +#include <linux/miscdevice.h>
> +

What was this for ?

Irrespective of that,

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
