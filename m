From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 5 Nov 2012 09:19:25 +0100
Subject: [PATCH 2/9] ARM: at91: Remove unused struct
 at91sam9g45_isi_device and its resources
In-Reply-To: <5097753F.7080307@atmel.com>
References: <1351980150-24145-1-git-send-email-lee.jones@linaro.org>
 <1351980150-24145-3-git-send-email-lee.jones@linaro.org>
 <5097753F.7080307@atmel.com>
Message-ID: <20121105081925.GA2699@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >This the at91sam9g45_isi_device structure and its associated resources
> >were added in 2008 and have been unused ever since. Let's remove them.
> 
> I'm the maintainer of the Atmel ISI driver. Currently the ISI still
> not work on at91sam9263 board.
> But this task is in my plan. So keep those code and I will enable
> ISI support for 9263 in the future. Thanks.

No problem at all. Thanks for getting back to me Josh.

Kind regards,
Lee

> >Cc: Russell King <linux@arm.linux.org.uk>
> >Cc: linux-arm-kernel at lists.infradead.org
> >Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >---
> >  arch/arm/mach-at91/at91sam9263_devices.c |   20 --------------------
> >  1 file changed, 20 deletions(-)
> >
> >diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
> >index cb85da2..0562a9d 100644
> >--- a/arch/arm/mach-at91/at91sam9263_devices.c
> >+++ b/arch/arm/mach-at91/at91sam9263_devices.c
> >@@ -901,26 +901,6 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
> >  #if defined(CONFIG_VIDEO_AT91_ISI) || defined(CONFIG_VIDEO_AT91_ISI_MODULE)
> >-struct resource isi_resources[] = {
> >-	[0] = {
> >-		.start	= AT91SAM9263_BASE_ISI,
> >-		.end	= AT91SAM9263_BASE_ISI + SZ_16K - 1,
> >-		.flags	= IORESOURCE_MEM,
> >-	},
> >-	[1] = {
> >-		.start	= NR_IRQS_LEGACY + AT91SAM9263_ID_ISI,
> >-		.end	= NR_IRQS_LEGACY + AT91SAM9263_ID_ISI,
> >-		.flags	= IORESOURCE_IRQ,
> >-	},
> >-};
> >-
> >-static struct platform_device at91sam9263_isi_device = {
> >-	.name		= "at91_isi",
> >-	.id		= -1,
> >-	.resource	= isi_resources,
> >-	.num_resources	= ARRAY_SIZE(isi_resources),
> >-};
> >-
> >  void __init at91_add_device_isi(struct isi_platform_data *data,
> >  		bool use_pck_as_mck)
> >  {
> 

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
