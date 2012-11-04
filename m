From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 4 Nov 2012 11:15:02 +0100
Subject: [PATCH 2/9] ARM: at91: Remove unused struct
 at91sam9g45_isi_device and its resources
In-Reply-To: <1351980150-24145-3-git-send-email-lee.jones@linaro.org>
References: <1351980150-24145-1-git-send-email-lee.jones@linaro.org>
 <1351980150-24145-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20121104101502.GI19021@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23:02 Sat 03 Nov     , Lee Jones wrote:
> This the at91sam9g45_isi_device structure and its associated resources
> were added in 2008 and have been unused ever since. Let's remove them.
next time you need to Cc the matinaers

NACK

Best Regards,
J.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/mach-at91/at91sam9263_devices.c |   20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
> index cb85da2..0562a9d 100644
> --- a/arch/arm/mach-at91/at91sam9263_devices.c
> +++ b/arch/arm/mach-at91/at91sam9263_devices.c
> @@ -901,26 +901,6 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
>  
>  #if defined(CONFIG_VIDEO_AT91_ISI) || defined(CONFIG_VIDEO_AT91_ISI_MODULE)
>  
> -struct resource isi_resources[] = {
> -	[0] = {
> -		.start	= AT91SAM9263_BASE_ISI,
> -		.end	= AT91SAM9263_BASE_ISI + SZ_16K - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= NR_IRQS_LEGACY + AT91SAM9263_ID_ISI,
> -		.end	= NR_IRQS_LEGACY + AT91SAM9263_ID_ISI,
> -		.flags	= IORESOURCE_IRQ,
> -	},
> -};
> -
> -static struct platform_device at91sam9263_isi_device = {
> -	.name		= "at91_isi",
> -	.id		= -1,
> -	.resource	= isi_resources,
> -	.num_resources	= ARRAY_SIZE(isi_resources),
> -};
> -
>  void __init at91_add_device_isi(struct isi_platform_data *data,
>  		bool use_pck_as_mck)
>  {
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
