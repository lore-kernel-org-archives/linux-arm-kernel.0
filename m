From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Mon, 16 Apr 2012 10:59:36 -0700
Subject: [PATCH] ARM: bcmring: fix build error due to bad
 AMBA_APB_DEVICE init
In-Reply-To: <1334553865-10874-1-git-send-email-olof@lixom.net>
References: <1334553865-10874-1-git-send-email-olof@lixom.net>
Message-ID: <4F8C5E08.7010805@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/15/2012 10:24 PM, Olof Johansson wrote:
> Seems to have been introduced by:
> 8ede1ae65 ARM: amba: bcmring: use common amba device initializers
>
> 'id' is the missing parameter, and with the old initializer the value
> used was 0. Use the same here.
>
> arch/arm/mach-bcmring/core.c:55:77: error: macro "AMBA_APB_DEVICE" requires 6 arguments, but only 5 given
> arch/arm/mach-bcmring/core.c:55:8: warning: type defaults to 'int' in declaration of 'AMBA_APB_DEVICE' [-Wimplicit-int]
> arch/arm/mach-bcmring/core.c:56:77: error: macro "AMBA_APB_DEVICE" requires 6 arguments, but only 5 given
> arch/arm/mach-bcmring/core.c:56:8: warning: type defaults to 'int' in declaration of 'AMBA_APB_DEVICE' [-Wimplicit-int]
>
> Signed-off-by: Olof Johansson<olof@lixom.net>
> Cc: Russell King<linux@arm.linux.org.uk>
> Cc: Jiandong Zheng<jdzheng@broadcom.com>
> ---
>   arch/arm/mach-bcmring/core.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-bcmring/core.c b/arch/arm/mach-bcmring/core.c
> index 22e4e0a..56d8b0f 100644
> --- a/arch/arm/mach-bcmring/core.c
> +++ b/arch/arm/mach-bcmring/core.c
> @@ -52,8 +52,8 @@
>   #include<mach/csp/chipcHw_inline.h>
>   #include<mach/csp/tmrHw_reg.h>
>
> -static AMBA_APB_DEVICE(uartA, "uarta", MM_ADDR_IO_UARTA, { IRQ_UARTA }, NULL);
> -static AMBA_APB_DEVICE(uartB, "uartb", MM_ADDR_IO_UARTB, { IRQ_UARTB }, NULL);
> +static AMBA_APB_DEVICE(uartA, "uarta", 0, MM_ADDR_IO_UARTA, { IRQ_UARTA }, NULL);
> +static AMBA_APB_DEVICE(uartB, "uartb", 0, MM_ADDR_IO_UARTB, { IRQ_UARTB }, NULL);
>
>   static struct clk pll1_clk = {
>   	.name = "PLL1",
Acked-by: Jiandong Zheng <jdzheng@broadcom.com>
