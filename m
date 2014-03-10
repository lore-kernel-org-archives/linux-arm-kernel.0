From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 10 Mar 2014 01:28:08 +0100
Subject: [PATCH 1/3] drivers: clk: add samsung common clock config option
In-Reply-To: <1393392247-6247-2-git-send-email-pankaj.dubey@samsung.com>
References: <1393392247-6247-1-git-send-email-pankaj.dubey@samsung.com>
 <1393392247-6247-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <531D0718.8000305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 26.02.2014 06:24, Pankaj Dubey wrote:
> add samsung common clock config option and let ARCH_EXYNOS or ARCH_S3CXXXX
> select this if they want to use samsung common clock infrastructure.
>
> CC: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>   drivers/clk/Kconfig  |   10 ++++++++++
>   drivers/clk/Makefile |    2 +-
>   2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 7641965..d93a325 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -23,6 +23,16 @@ config COMMON_CLK
>   menu "Common Clock Framework"
>   	depends on COMMON_CLK
>
> +config COMMON_CLK_SAMSUNG
> +	bool "Clock driver for Samsung SoCs"
> +	depends on ARCH_S3C64XX || ARCH_S3C24XX || ARCH_EXYNOS || ARM64
> +	---help---
> +          Supports clocking on Exynos SoCs:
> +	  - Exynos5250, Exynos5420 board.
> +	  - Exynos4 boards.
> +	  - S3C2412, S3C2416, S3C2466 boards.
> +	  - S3C64XX boards.

I don't think listing the platforms here explicitly is a good idea, as 
this option shouldn't generally be user-visible (related platforms would 
not work without this option enabled) and adding support for every new 
SoC would require changing the help string.

I wonder if we really need this to be user-visible. What about moving it 
out of this menu, making the symbol select COMMON_CLK and let the 
platforms just select COMMON_CLK_SAMSUNG alone?

Best regards,
Tomasz
