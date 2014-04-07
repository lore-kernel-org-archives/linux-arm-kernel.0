From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Mon, 07 Apr 2014 18:01:58 +0300
Subject: [PATCH v2] clk: qcom: Add support for IPQ8064's global clock
 controller (GCC)
In-Reply-To: <1396642749-12979-1-git-send-email-galak@codeaurora.org>
References: <1396642749-12979-1-git-send-email-galak@codeaurora.org>
Message-ID: <1396882918.28420.37.camel@iivanov-dev>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kumar,

On Fri, 2014-04-04 at 15:19 -0500, Kumar Gala wrote:
> Add a driver for the global clock controller found on IPQ8064 based
> platforms. This should allow most non-multimedia device drivers to probe
> and control their clocks.
> 
> This is currently missing clocks for SATA, USB, and networking devices.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> ---
> v2:
> * dropped audio clock from commit message
> * changed Kconfig symbol to IPQ_GCC_806X
> * Fixed PXO/CXO clk freq to 25Mhz
> 

<snip>

> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-ipq806x.c
> @@ -0,0 +1,1957 @@
> +/*
> + * Copyright (c) 2014, The Linux Foundation. All rights reserved.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/clk-provider.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +#include <dt-bindings/clock/qcom,gcc-ipq806x.h>
> +#include <dt-bindings/reset/qcom,gcc-ipq806x.h>
> +
> +#include "common.h"

Do I miss something or this file is not available?

Regards,
Ivan
