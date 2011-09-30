From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 30 Sep 2011 12:03:07 -0500
Subject: [PATCH 1/2] ARM: CLKDEV: Add Common Macro for clk_lookup
In-Reply-To: <1317381097-2691-2-git-send-email-padma.v@samsung.com>
References: <1317381097-2691-1-git-send-email-padma.v@samsung.com>
	<1317381097-2691-2-git-send-email-padma.v@samsung.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F39DC5675B@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 30, 2011 4:12 AM, Padmavathi Venna wrote:
>
> Added a standardized macro CLKDEV_INIT which can used across all
> the platforms to support clkdev
>
> Suggested by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

> ---
>  include/linux/clkdev.h |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
> index 457bcb0..f2db158 100644
> --- a/include/linux/clkdev.h
> +++ b/include/linux/clkdev.h
> @@ -14,6 +14,13 @@
>  
>  #include <asm/clkdev.h>
>  
> +#define CLKDEV_INIT(d, n, c) \
> +	{ \
> +		.dev_id = d, \
> +		.con_id = n, \
> +		.clk = &c, \
> +	},
> +
>  struct clk;
>  struct device;
