From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Thu, 11 May 2017 10:30:20 +0300
Subject: [PATCH v5 2/3] phy: Move ULPI phy header out of drivers to
 include path
In-Reply-To: <1494485262-18995-2-git-send-email-vivek.gautam@codeaurora.org>
References: <1494485262-18995-1-git-send-email-vivek.gautam@codeaurora.org>
 <1494485262-18995-2-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <20170511073020.GA7676@kuha.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 11, 2017 at 12:17:41PM +0530, Vivek Gautam wrote:
> Although ULPI phy is currently being used by tusb1210,
> there can be other consumers too in future. So move this
> to the includes path for phy.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Cc: Stephen Boyd <stephen.boyd@linaro.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-omap at vger.kernel.org
> Cc: linux-usb at vger.kernel.org
> ---

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> Changes since v4:
>  - None.
> 
> Changes since v3:
>  - Removed qcom phy changes, since patch - 1/3 addressed that now.
> 
> Changes since v2:
>  - Updated the location for this header in drivers using it.
> 
>  drivers/phy/phy-tusb1210.c                | 3 +--
>  {drivers => include/linux}/phy/ulpi_phy.h | 0
>  2 files changed, 1 insertion(+), 2 deletions(-)
>  rename {drivers => include/linux}/phy/ulpi_phy.h (100%)
> 
> diff --git a/drivers/phy/phy-tusb1210.c b/drivers/phy/phy-tusb1210.c
> index 4f6d5e71507d..bb3fb031c478 100644
> --- a/drivers/phy/phy-tusb1210.c
> +++ b/drivers/phy/phy-tusb1210.c
> @@ -12,8 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/ulpi/driver.h>
>  #include <linux/gpio/consumer.h>
> -
> -#include "ulpi_phy.h"
> +#include <linux/phy/ulpi_phy.h>
>  
>  #define TUSB1210_VENDOR_SPECIFIC2		0x80
>  #define TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT	0
> diff --git a/drivers/phy/ulpi_phy.h b/include/linux/phy/ulpi_phy.h
> similarity index 100%
> rename from drivers/phy/ulpi_phy.h
> rename to include/linux/phy/ulpi_phy.h
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project

-- 
heikki
