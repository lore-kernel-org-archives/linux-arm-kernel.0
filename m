From: gwenhael.goavec-merou@armadeus.com (gwenhael.goavec)
Date: Mon, 25 Mar 2013 12:01:14 +0100
Subject: [PATCH] ARM: imx1: mm: add call to mxc_device_init
In-Reply-To: <1363448999-3936-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1363448999-3936-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20130325120114.15e11bc0@dell.trabucayre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping?
Gwenhael

On Sat, 16 Mar 2013 16:49:59 +0100
Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com> wrote:

> mxc_device_init() is mandatory for mxc_aips and mxc_ahb bus registration, needed 
> as parents, at least, for gpio and dma.
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> ---
>  arch/arm/mach-imx/mm-imx1.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mm-imx1.c b/arch/arm/mach-imx/mm-imx1.c
> index 7a14667..3c609c5 100644
> --- a/arch/arm/mach-imx/mm-imx1.c
> +++ b/arch/arm/mach-imx/mm-imx1.c
> @@ -51,6 +51,8 @@ void __init mx1_init_irq(void)
>  
>  void __init imx1_soc_init(void)
>  {
> +	mxc_device_init();
> +
>  	mxc_register_gpio("imx1-gpio", 0, MX1_GPIO1_BASE_ADDR, SZ_256,
>  						MX1_GPIO_INT_PORTA, 0);
>  	mxc_register_gpio("imx1-gpio", 1, MX1_GPIO2_BASE_ADDR, SZ_256,
> -- 
> 1.8.1.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
