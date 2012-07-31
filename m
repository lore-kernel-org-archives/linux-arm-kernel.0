From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 31 Jul 2012 20:58:03 +0000
Subject: [PATCH 4/6] ARM: ux500: Fix merge error,
 so such struct 'snd_soc_u8500'
In-Reply-To: <1343741493-17671-9-git-send-email-lee.jones@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-9-git-send-email-lee.jones@linaro.org>
Message-ID: <201207312058.03640.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 31 July 2012, Lee Jones wrote:
>  arch/arm/mach-ux500/board-mop500-msp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-ux500/board-mop500-msp.c b/arch/arm/mach-ux500/board-mop500-msp.c
> index 9960480..1b6a193 100644
> --- a/arch/arm/mach-ux500/board-mop500-msp.c
> +++ b/arch/arm/mach-ux500/board-mop500-msp.c
> @@ -228,7 +228,7 @@ int mop500_msp_init(struct device *parent)
>         struct platform_device *msp1;
>  
>         pr_info("%s: Register platform-device 'snd-soc-u8500'.\n", __func__);
> -       platform_device_register(&snd_soc_u8500);
> +       platform_device_register(&snd_soc_mop500);
>  
>         pr_info("Initialize MSP I2S-devices.\n");
>         db8500_add_msp_i2s(parent, 0, U8500_MSP0_BASE, IRQ_DB8500_MSP0,

Against which tree is this? In upstream I only see the snd_soc_u8500 device,
not snd_soc_mop500.

	Arnd
