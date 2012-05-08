From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 08 May 2012 14:38:23 +0900
Subject: [PATCH 3/5] ARM: S3C24XX: move plat-s3c24xx/dev-uart.c into
 common.c
In-Reply-To: <201205071942.12082.heiko@sntech.de>
References: <201205071939.37433.heiko@sntech.de>
 <201205071942.12082.heiko@sntech.de>
Message-ID: <017801cd2cdc$ca6ef8f0$5f4cead0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> The uart devices are used on all s3c24xx machines, so they can reside
> in the common code for all machines.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/mach-s3c24xx/common.c   |   73 +++++++++++++++++++++++++++
>  arch/arm/plat-s3c24xx/Makefile   |    1 -
>  arch/arm/plat-s3c24xx/dev-uart.c |  100 ---------------------------------
> -----
>  3 files changed, 73 insertions(+), 101 deletions(-)
>  delete mode 100644 arch/arm/plat-s3c24xx/dev-uart.c
> 
> diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-
> s3c24xx/common.c
> index 755d5f1..bf1cd36 100644
> --- a/arch/arm/mach-s3c24xx/common.c
> +++ b/arch/arm/mach-s3c24xx/common.c
> @@ -876,3 +876,76 @@ struct syscore_ops s3c24xx_irq_syscore_ops = {
>  	.suspend	= s3c24xx_irq_suspend,
>  	.resume		= s3c24xx_irq_resume,
>  };
> +
> +/* Serial port registrations */
> +
> +static struct resource s3c2410_uart0_resource[] = {
> +	[0] = {
> +		.start = S3C2410_PA_UART0,
> +		.end   = S3C2410_PA_UART0 + 0x3fff,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start = IRQ_S3CUART_RX0,
> +		.end   = IRQ_S3CUART_ERR0,
> +		.flags = IORESOURCE_IRQ,
> +	}

+	[0] = DEFINE_RES_MEM(S3C2410_PA_UART0, SZ_16K),
+	[1] = DEFINE_RES_NAMED(IRQ_S3CUART_RX0, \
+			IRQ_S3CUART_ERR0 - IRQ_S3CUART_RX0 + 1, \
+			NULL, IORESOURCE_IRQ)

Note, Tushar's patch updated so I will update when apply this.

[...]

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
