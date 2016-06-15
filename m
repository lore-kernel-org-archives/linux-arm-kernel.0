From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 15 Jun 2016 11:24:12 -0400
Subject: [PATCH 3/5] clk: max77686: Add DT binding details for PMIC
 MAX77620
In-Reply-To: <1466000018-16784-4-git-send-email-ldewangan@nvidia.com>
References: <1466000018-16784-1-git-send-email-ldewangan@nvidia.com>
 <1466000018-16784-4-git-send-email-ldewangan@nvidia.com>
Message-ID: <78d6bff5-c037-6929-e352-320541ed1051@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Laxman,

On 06/15/2016 10:13 AM, Laxman Dewangan wrote:
> Maxim has used the same clock IP on multiple PMICs like
> MAX77686, MAX77802, MAX77620. Only differences are the
> number of clocks from these PMICs.
> 
> Add clock binding details and example for the max77620 in
> maxim,max77686.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: Javier Martinez Canillas <javier@dowhile0.org>
> ---
>  .../devicetree/bindings/clock/maxim,max77686.txt   | 38 +++++++++++++++++++---
>  include/dt-bindings/mfd/max77620.h                 |  4 +++

[snip]

> +		};
> diff --git a/include/dt-bindings/mfd/max77620.h b/include/dt-bindings/mfd/max77620.h
> index b911a07..e1bd08c 100644
> --- a/include/dt-bindings/mfd/max77620.h
> +++ b/include/dt-bindings/mfd/max77620.h
> @@ -36,4 +36,8 @@
>  #define MAX77620_FPS_SRC_NONE			3
>  #define MAX77620_FPS_SRC_DEF			4
>  
> +/* MAX77686 clocks */
> +#define MAX77620_CLKS_NUM			1
> +#define MAX77620_CLK_32K_OUT0			0
> +
>  #endif
> 

The clocks for the other Maxim PMICs define their clocks in the clock subdir
instead, so I wonder if include/dt-bindings/clock/maxim,max77620.h wouldn't
be better for consistency?

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
