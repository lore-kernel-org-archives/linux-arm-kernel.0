From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 14 Jan 2016 18:10:26 -0800
Subject: [PATCH v3 02/13] clk: at91: make use of syscon/regmap internally
In-Reply-To: <1449248628-3486-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1449248628-3486-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1449248628-3486-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160115021026.GR22188@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04, Alexandre Belloni wrote:
> diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
> index abc80949e1dd..0b9e0aeef346 100644
> --- a/drivers/clk/at91/clk-generated.c
> +++ b/drivers/clk/at91/clk-generated.c
> @@ -17,9 +17,13 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
>  
>  #include "pmc.h"
>  
> +extern spinlock_t pmc_pcr_lock;

You can throw this extern into pmc.h?

> +
>  #define PERIPHERAL_MAX		64
>  #define PERIPHERAL_ID_MIN	2
>  
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
