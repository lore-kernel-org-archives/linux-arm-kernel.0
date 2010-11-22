From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 22 Nov 2010 09:26:44 +0800
Subject: [PATCH 2/2] ARM: pxa/raumfeld: enable PXA3XX_GCU driver
In-Reply-To: <1288896241-8318-3-git-send-email-zonque@gmail.com>
References: <1288896241-8318-1-git-send-email-zonque@gmail.com>
	<1288896241-8318-3-git-send-email-zonque@gmail.com>
Message-ID: <AANLkTimQU9u_KXEPJ7_pGg361Scp80otwe+R8ow3MTfG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 5, 2010 at 2:44 AM, Daniel Mack <zonque@gmail.com> wrote:
> From: Daniel Mack <daniel@caiaq.de>
>

Applied with your SOB.

> ---
> ?arch/arm/mach-pxa/raumfeld.c | ? ?5 +++++
> ?1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
> index 67e04f4..bbf0b61 100644
> --- a/arch/arm/mach-pxa/raumfeld.c
> +++ b/arch/arm/mach-pxa/raumfeld.c
> @@ -588,6 +588,9 @@ static struct pxafb_mach_info raumfeld_sharp_lcd_info = {
> ? ? ? ?.num_modes ? ? ?= 1,
> ? ? ? ?.video_mem_size = 0x400000,
> ? ? ? ?.lcd_conn ? ? ? = LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
> +#ifdef CONFIG_PXA3XX_GCU
> + ? ? ? .acceleration_enabled = 1,
> +#endif
> ?};
>
> ?static void __init raumfeld_lcd_init(void)
> @@ -616,6 +619,8 @@ static void __init raumfeld_lcd_init(void)
> ? ? ? ? ? ? ? ?pr_warning("Unable to request GPIO_DISPLAY_ENABLE\n");
> ? ? ? ?else
> ? ? ? ? ? ? ? ?gpio_direction_output(GPIO_DISPLAY_ENABLE, 1);
> +
> + ? ? ? platform_device_register(&pxa3xx_device_gcu);
> ?}
>
> ?/**
> --
> 1.7.1
>
>
