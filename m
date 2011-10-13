From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 13 Oct 2011 13:07:02 -0600
Subject: [PATCH v4 1/8] ARM: pxa: rename IRQ_GPIO to PXA_GPIO_TO_IRQ
In-Reply-To: <1318478825-17187-2-git-send-email-haojian.zhuang@marvell.com>
References: <1318478825-17187-1-git-send-email-haojian.zhuang@marvell.com>
	<1318478825-17187-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20111013190702.GS18574@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 12:06:58PM +0800, Haojian Zhuang wrote:
> Avoid potential naming confliction since multiple architecture will be built
> in a single kernel.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  arch/arm/mach-pxa/am200epd.c                      |    4 +-
>  arch/arm/mach-pxa/am300epd.c                      |    4 +-
>  arch/arm/mach-pxa/balloon3.c                      |    2 +-
>  arch/arm/mach-pxa/cm-x270.c                       |    2 +-
>  arch/arm/mach-pxa/cm-x2xx.c                       |    4 +-
>  arch/arm/mach-pxa/cm-x300.c                       |    6 +-
>  arch/arm/mach-pxa/em-x270.c                       |    6 +-
>  arch/arm/mach-pxa/eseries.c                       |    4 +-
>  arch/arm/mach-pxa/idp.c                           |    4 +-
>  arch/arm/mach-pxa/include/mach/balloon3.h         |    6 +-
>  arch/arm/mach-pxa/include/mach/corgi.h            |   24 +++++-----
>  arch/arm/mach-pxa/include/mach/gpio.h             |    2 +-
>  arch/arm/mach-pxa/include/mach/gumstix.h          |   20 +++++-----
>  arch/arm/mach-pxa/include/mach/idp.h              |   14 +++---
>  arch/arm/mach-pxa/include/mach/irqs.h             |    2 +-
>  arch/arm/mach-pxa/include/mach/palmld.h           |    8 ++--
>  arch/arm/mach-pxa/include/mach/palmt5.h           |    8 ++--
>  arch/arm/mach-pxa/include/mach/palmtc.h           |    4 +-
>  arch/arm/mach-pxa/include/mach/palmtx.h           |    8 ++--
>  arch/arm/mach-pxa/include/mach/pcm027.h           |    8 ++--
>  arch/arm/mach-pxa/include/mach/pcm990_baseboard.h |   14 +++---
>  arch/arm/mach-pxa/include/mach/poodle.h           |   24 +++++-----
>  arch/arm/mach-pxa/include/mach/spitz.h            |   34 ++++++++--------
>  arch/arm/mach-pxa/include/mach/tosa.h             |   46 ++++++++++----------
>  arch/arm/mach-pxa/include/mach/trizeps4.h         |   16 ++++----
>  arch/arm/mach-pxa/littleton.c                     |    4 +-
>  arch/arm/mach-pxa/lpd270.c                        |    4 +-
>  arch/arm/mach-pxa/lubbock.c                       |    4 +-
>  arch/arm/mach-pxa/mainstone.c                     |    4 +-
>  arch/arm/mach-pxa/poodle.c                        |    4 +-
>  arch/arm/mach-pxa/sharpsl_pm.c                    |   24 +++++-----
>  arch/arm/mach-pxa/stargate2.c                     |   22 +++++-----
>  arch/arm/mach-pxa/vpac270.c                       |    6 +-
>  arch/arm/mach-pxa/zylonite_pxa300.c               |    4 +-
>  34 files changed, 175 insertions(+), 175 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
> index 4cb069f..ccdac4b 100644
> --- a/arch/arm/mach-pxa/am200epd.c
> +++ b/arch/arm/mach-pxa/am200epd.c
> @@ -138,7 +138,7 @@ static void am200_cleanup(struct metronomefb_par *par)
>  {
>  	int i;
>  
> -	free_irq(IRQ_GPIO(RDY_GPIO_PIN), par);
> +	free_irq(PXA_GPIO_TO_IRQ(RDY_GPIO_PIN), par);
>  
>  	for (i = 0; i < ARRAY_SIZE(gpios); i++)
>  		gpio_free(gpios[i]);
> @@ -292,7 +292,7 @@ static int am200_setup_irq(struct fb_info *info)
>  {
>  	int ret;
>  
> -	ret = request_irq(IRQ_GPIO(RDY_GPIO_PIN), am200_handle_irq,
> +	ret = request_irq(PXA_GPIO_TO_IRQ(RDY_GPIO_PIN), am200_handle_irq,
>  				IRQF_DISABLED|IRQF_TRIGGER_FALLING,
>  				"AM200", info->par);
>  	if (ret)
> diff --git a/arch/arm/mach-pxa/am300epd.c b/arch/arm/mach-pxa/am300epd.c
> index fa8bad2..76c4b94 100644
> --- a/arch/arm/mach-pxa/am300epd.c
> +++ b/arch/arm/mach-pxa/am300epd.c
> @@ -176,7 +176,7 @@ static void am300_cleanup(struct broadsheetfb_par *par)
>  {
>  	int i;
>  
> -	free_irq(IRQ_GPIO(RDY_GPIO_PIN), par);
> +	free_irq(PXA_GPIO_TO_IRQ(RDY_GPIO_PIN), par);
>  
>  	for (i = 0; i < ARRAY_SIZE(gpios); i++)
>  		gpio_free(gpios[i]);
> @@ -240,7 +240,7 @@ static int am300_setup_irq(struct fb_info *info)
>  	int ret;
>  	struct broadsheetfb_par *par = info->par;
>  
> -	ret = request_irq(IRQ_GPIO(RDY_GPIO_PIN), am300_handle_irq,
> +	ret = request_irq(PXA_GPIO_TO_IRQ(RDY_GPIO_PIN), am300_handle_irq,
>  				IRQF_DISABLED|IRQF_TRIGGER_RISING,
>  				"AM300", par);
>  	if (ret)
> diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
> index 7765d67..9164281 100644
> --- a/arch/arm/mach-pxa/balloon3.c
> +++ b/arch/arm/mach-pxa/balloon3.c
> @@ -179,7 +179,7 @@ static unsigned long balloon3_ac97_pin_config[] __initdata = {
>  };
>  
>  static struct ucb1400_pdata vpac270_ucb1400_pdata = {
> -	.irq		= IRQ_GPIO(BALLOON3_GPIO_CODEC_IRQ),
> +	.irq		= PXA_GPIO_TO_IRQ(BALLOON3_GPIO_CODEC_IRQ),
>  };
>  
>  
> diff --git a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
> index 13518a7..4ebcee5 100644
> --- a/arch/arm/mach-pxa/cm-x270.c
> +++ b/arch/arm/mach-pxa/cm-x270.c
> @@ -33,7 +33,7 @@
>  /* GPIO IRQ usage */
>  #define GPIO83_MMC_IRQ		(83)
>  
> -#define CMX270_MMC_IRQ		IRQ_GPIO(GPIO83_MMC_IRQ)
> +#define CMX270_MMC_IRQ		PXA_GPIO_TO_IRQ(GPIO83_MMC_IRQ)
>  
>  /* MMC power enable */
>  #define GPIO105_MMC_POWER	(105)
> diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
> index 349896c..6211378 100644
> --- a/arch/arm/mach-pxa/cm-x2xx.c
> +++ b/arch/arm/mach-pxa/cm-x2xx.c
> @@ -58,8 +58,8 @@ extern void cmx270_init(void);
>  #define CMX255_GPIO_IT8152_IRQ	(0)
>  #define CMX270_GPIO_IT8152_IRQ	(22)
>  
> -#define CMX255_ETHIRQ		IRQ_GPIO(GPIO22_ETHIRQ)
> -#define CMX270_ETHIRQ		IRQ_GPIO(GPIO10_ETHIRQ)
> +#define CMX255_ETHIRQ		PXA_GPIO_TO_IRQ(GPIO22_ETHIRQ)
> +#define CMX270_ETHIRQ		PXA_GPIO_TO_IRQ(GPIO10_ETHIRQ)
>  
>  #if defined(CONFIG_DM9000) || defined(CONFIG_DM9000_MODULE)
>  static struct resource cmx255_dm9000_resource[] = {
> diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
> index d2da301..7ff8a27 100644
> --- a/arch/arm/mach-pxa/cm-x300.c
> +++ b/arch/arm/mach-pxa/cm-x300.c
> @@ -64,7 +64,7 @@
>  #define GPIO82_MMC_IRQ		(82)
>  #define GPIO85_MMC_WP		(85)
>  
> -#define	CM_X300_MMC_IRQ		IRQ_GPIO(GPIO82_MMC_IRQ)
> +#define	CM_X300_MMC_IRQ		PXA_GPIO_TO_IRQ(GPIO82_MMC_IRQ)
>  
>  #define GPIO95_RTC_CS		(95)
>  #define GPIO96_RTC_WR		(96)
> @@ -229,8 +229,8 @@ static struct resource dm9000_resources[] = {
>  		.flags	= IORESOURCE_MEM,
>  	},
>  	[2] = {
> -		.start	= IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO99)),
> -		.end	= IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO99)),
> +		.start	= PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO99)),
> +		.end	= PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO99)),
>  		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
>  	}
>  };
> diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
> index 94acc0b..3358f4d 100644
> --- a/arch/arm/mach-pxa/em-x270.c
> +++ b/arch/arm/mach-pxa/em-x270.c
> @@ -70,7 +70,7 @@
>  /* common  GPIOs */
>  #define GPIO11_NAND_CS		(11)
>  #define GPIO41_ETHIRQ		(41)
> -#define EM_X270_ETHIRQ		IRQ_GPIO(GPIO41_ETHIRQ)
> +#define EM_X270_ETHIRQ		PXA_GPIO_TO_IRQ(GPIO41_ETHIRQ)
>  #define GPIO115_WLAN_PWEN	(115)
>  #define GPIO19_WLAN_STRAP	(19)
>  #define GPIO9_USB_VBUS_EN	(9)
> @@ -805,7 +805,7 @@ static struct spi_board_info em_x270_spi_devices[] __initdata = {
>  		.modalias		= "libertas_spi",
>  		.max_speed_hz		= 13000000,
>  		.bus_num		= 2,
> -		.irq			= IRQ_GPIO(116),
> +		.irq			= PXA_GPIO_TO_IRQ(116),
>  		.chip_select		= 0,
>  		.controller_data	= &em_x270_libertas_chip,
>  		.platform_data		= &em_x270_libertas_pdata,
> @@ -1203,7 +1203,7 @@ static struct da903x_platform_data em_x270_da9030_info = {
>  
>  static struct i2c_board_info em_x270_i2c_pmic_info = {
>  	I2C_BOARD_INFO("da9030", 0x49),
> -	.irq = IRQ_GPIO(0),
> +	.irq = PXA_GPIO_TO_IRQ(0),
>  	.platform_data = &em_x270_da9030_info,
>  };
>  
> diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
> index 8e697dd..cf84051 100644
> --- a/arch/arm/mach-pxa/eseries.c
> +++ b/arch/arm/mach-pxa/eseries.c
> @@ -119,8 +119,8 @@ struct resource eseries_tmio_resources[] = {
>  		.flags  = IORESOURCE_MEM,
>  	},
>  	[1] = {
> -		.start  = IRQ_GPIO(GPIO_ESERIES_TMIO_IRQ),
> -		.end    = IRQ_GPIO(GPIO_ESERIES_TMIO_IRQ),
> +		.start  = PXA_GPIO_TO_IRQ(GPIO_ESERIES_TMIO_IRQ),
> +		.end    = PXA_GPIO_TO_IRQ(GPIO_ESERIES_TMIO_IRQ),
>  		.flags  = IORESOURCE_IRQ,
>  	},
>  };
> diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
> index ddf20e5..bb98ff5 100644
> --- a/arch/arm/mach-pxa/idp.c
> +++ b/arch/arm/mach-pxa/idp.c
> @@ -75,8 +75,8 @@ static struct resource smc91x_resources[] = {
>  		.flags	= IORESOURCE_MEM,
>  	},
>  	[1] = {
> -		.start	= IRQ_GPIO(4),
> -		.end	= IRQ_GPIO(4),
> +		.start	= PXA_GPIO_TO_IRQ(4),
> +		.end	= PXA_GPIO_TO_IRQ(4),
>  		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
>  	}
>  };
> diff --git a/arch/arm/mach-pxa/include/mach/balloon3.h b/arch/arm/mach-pxa/include/mach/balloon3.h
> index 7074e76..65cb71f 100644
> --- a/arch/arm/mach-pxa/include/mach/balloon3.h
> +++ b/arch/arm/mach-pxa/include/mach/balloon3.h
> @@ -172,9 +172,9 @@ enum balloon3_features {
>  /* Balloon3 Interrupts */
>  #define BALLOON3_IRQ(x)		(IRQ_BOARD_START + (x))
>  
> -#define BALLOON3_AUX_NIRQ	IRQ_GPIO(BALLOON3_GPIO_AUX_NIRQ)
> -#define BALLOON3_CODEC_IRQ	IRQ_GPIO(BALLOON3_GPIO_CODEC_IRQ)
> -#define BALLOON3_S0_CD_IRQ	IRQ_GPIO(BALLOON3_GPIO_S0_CD)
> +#define BALLOON3_AUX_NIRQ	PXA_GPIO_TO_IRQ(BALLOON3_GPIO_AUX_NIRQ)
> +#define BALLOON3_CODEC_IRQ	PXA_GPIO_TO_IRQ(BALLOON3_GPIO_CODEC_IRQ)
> +#define BALLOON3_S0_CD_IRQ	PXA_GPIO_TO_IRQ(BALLOON3_GPIO_S0_CD)
>  
>  #define BALLOON3_NR_IRQS	(IRQ_BOARD_START + 16)
>  
> diff --git a/arch/arm/mach-pxa/include/mach/corgi.h b/arch/arm/mach-pxa/include/mach/corgi.h
> index 5dfd119..c9f8617 100644
> --- a/arch/arm/mach-pxa/include/mach/corgi.h
> +++ b/arch/arm/mach-pxa/include/mach/corgi.h
> @@ -66,18 +66,18 @@
>  /*
>   * Corgi Interrupts
>   */
> -#define CORGI_IRQ_GPIO_KEY_INT		IRQ_GPIO(0)
> -#define CORGI_IRQ_GPIO_AC_IN		IRQ_GPIO(1)
> -#define CORGI_IRQ_GPIO_WAKEUP		IRQ_GPIO(3)
> -#define CORGI_IRQ_GPIO_AK_INT		IRQ_GPIO(4)
> -#define CORGI_IRQ_GPIO_TP_INT		IRQ_GPIO(5)
> -#define CORGI_IRQ_GPIO_nSD_DETECT	IRQ_GPIO(9)
> -#define CORGI_IRQ_GPIO_nSD_INT		IRQ_GPIO(10)
> -#define CORGI_IRQ_GPIO_MAIN_BAT_LOW	IRQ_GPIO(11)
> -#define CORGI_IRQ_GPIO_CF_CD		IRQ_GPIO(14)
> -#define CORGI_IRQ_GPIO_CHRG_FULL	IRQ_GPIO(16)	/* Battery fully charged */
> -#define CORGI_IRQ_GPIO_CF_IRQ		IRQ_GPIO(17)
> -#define CORGI_IRQ_GPIO_KEY_SENSE(a)	IRQ_GPIO(58+(a))	/* Keyboard Sense lines */
> +#define CORGI_IRQ_GPIO_KEY_INT		PXA_GPIO_TO_IRQ(0)
> +#define CORGI_IRQ_GPIO_AC_IN		PXA_GPIO_TO_IRQ(1)
> +#define CORGI_IRQ_GPIO_WAKEUP		PXA_GPIO_TO_IRQ(3)
> +#define CORGI_IRQ_GPIO_AK_INT		PXA_GPIO_TO_IRQ(4)
> +#define CORGI_IRQ_GPIO_TP_INT		PXA_GPIO_TO_IRQ(5)
> +#define CORGI_IRQ_GPIO_nSD_DETECT	PXA_GPIO_TO_IRQ(9)
> +#define CORGI_IRQ_GPIO_nSD_INT		PXA_GPIO_TO_IRQ(10)
> +#define CORGI_IRQ_GPIO_MAIN_BAT_LOW	PXA_GPIO_TO_IRQ(11)
> +#define CORGI_IRQ_GPIO_CF_CD		PXA_GPIO_TO_IRQ(14)
> +#define CORGI_IRQ_GPIO_CHRG_FULL	PXA_GPIO_TO_IRQ(16)	/* Battery fully charged */
> +#define CORGI_IRQ_GPIO_CF_IRQ		PXA_GPIO_TO_IRQ(17)
> +#define CORGI_IRQ_GPIO_KEY_SENSE(a)	PXA_GPIO_TO_IRQ(58+(a))	/* Keyboard Sense lines */
>  
>  
>  /*
> diff --git a/arch/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h
> index 004cade..07fa3ba 100644
> --- a/arch/arm/mach-pxa/include/mach/gpio.h
> +++ b/arch/arm/mach-pxa/include/mach/gpio.h
> @@ -28,7 +28,7 @@
>  /* The defines for the driver are needed for the accelerated accessors */
>  #include "gpio-pxa.h"
>  
> -#define gpio_to_irq(gpio)	IRQ_GPIO(gpio)
> +#define gpio_to_irq(gpio)	PXA_GPIO_TO_IRQ(gpio)
>  
>  static inline int irq_to_gpio(unsigned int irq)
>  {
> diff --git a/arch/arm/mach-pxa/include/mach/gumstix.h b/arch/arm/mach-pxa/include/mach/gumstix.h
> index 9b89868..dba14b6 100644
> --- a/arch/arm/mach-pxa/include/mach/gumstix.h
> +++ b/arch/arm/mach-pxa/include/mach/gumstix.h
> @@ -24,7 +24,7 @@ has detected a cable insertion; driven low otherwise. */
>  #define GPIO_GUMSTIX_USB_GPIOx		41
>  
>  /* usb state change */
> -#define GUMSTIX_USB_INTR_IRQ		IRQ_GPIO(GPIO_GUMSTIX_USB_GPIOn)
> +#define GUMSTIX_USB_INTR_IRQ		PXA_GPIO_TO_IRQ(GPIO_GUMSTIX_USB_GPIOn)
>  
>  #define GPIO_GUMSTIX_USB_GPIOn_MD	(GPIO_GUMSTIX_USB_GPIOn | GPIO_IN)
>  #define GPIO_GUMSTIX_USB_GPIOx_CON_MD	(GPIO_GUMSTIX_USB_GPIOx | GPIO_OUT)
> @@ -35,7 +35,7 @@ has detected a cable insertion; driven low otherwise. */
>   */
>  #define GUMSTIX_GPIO_nSD_WP		22 /* SD Write Protect */
>  #define GUMSTIX_GPIO_nSD_DETECT		11 /* MMC/SD Card Detect */
> -#define GUMSTIX_IRQ_GPIO_nSD_DETECT	IRQ_GPIO(GUMSTIX_GPIO_nSD_DETECT)
> +#define GUMSTIX_IRQ_GPIO_nSD_DETECT	PXA_GPIO_TO_IRQ(GUMSTIX_GPIO_nSD_DETECT)
>  
>  /*
>   * SMC Ethernet definitions
> @@ -49,10 +49,10 @@ has detected a cable insertion; driven low otherwise. */
>  
>  #define GPIO_GUMSTIX_ETH0		36
>  #define GPIO_GUMSTIX_ETH0_MD		(GPIO_GUMSTIX_ETH0 | GPIO_IN)
> -#define GUMSTIX_ETH0_IRQ		IRQ_GPIO(GPIO_GUMSTIX_ETH0)
> +#define GUMSTIX_ETH0_IRQ		PXA_GPIO_TO_IRQ(GPIO_GUMSTIX_ETH0)
>  #define GPIO_GUMSTIX_ETH1		27
>  #define GPIO_GUMSTIX_ETH1_MD		(GPIO_GUMSTIX_ETH1 | GPIO_IN)
> -#define GUMSTIX_ETH1_IRQ		IRQ_GPIO(GPIO_GUMSTIX_ETH1)
> +#define GUMSTIX_ETH1_IRQ		PXA_GPIO_TO_IRQ(GPIO_GUMSTIX_ETH1)
>  
>  
>  /* CF reset line */
> @@ -63,18 +63,18 @@ has detected a cable insertion; driven low otherwise. */
>  #define GPIO4_nSTSCHG			GPIO4_nBVD1
>  #define GPIO11_nCD			11
>  #define GPIO26_PRDY_nBSY		26
> -#define GUMSTIX_S0_nSTSCHG_IRQ		IRQ_GPIO(GPIO4_nSTSCHG)
> -#define GUMSTIX_S0_nCD_IRQ		IRQ_GPIO(GPIO11_nCD)
> -#define GUMSTIX_S0_PRDY_nBSY_IRQ	IRQ_GPIO(GPIO26_PRDY_nBSY)
> +#define GUMSTIX_S0_nSTSCHG_IRQ		PXA_GPIO_TO_IRQ(GPIO4_nSTSCHG)
> +#define GUMSTIX_S0_nCD_IRQ		PXA_GPIO_TO_IRQ(GPIO11_nCD)
> +#define GUMSTIX_S0_PRDY_nBSY_IRQ	PXA_GPIO_TO_IRQ(GPIO26_PRDY_nBSY)
>  
>  /* CF slot 1 */
>  #define GPIO18_nBVD1			18
>  #define GPIO18_nSTSCHG			GPIO18_nBVD1
>  #define GPIO36_nCD			36
>  #define GPIO27_PRDY_nBSY		27
> -#define GUMSTIX_S1_nSTSCHG_IRQ		IRQ_GPIO(GPIO18_nSTSCHG)
> -#define GUMSTIX_S1_nCD_IRQ		IRQ_GPIO(GPIO36_nCD)
> -#define GUMSTIX_S1_PRDY_nBSY_IRQ	IRQ_GPIO(GPIO27_PRDY_nBSY)
> +#define GUMSTIX_S1_nSTSCHG_IRQ		PXA_GPIO_TO_IRQ(GPIO18_nSTSCHG)
> +#define GUMSTIX_S1_nCD_IRQ		PXA_GPIO_TO_IRQ(GPIO36_nCD)
> +#define GUMSTIX_S1_PRDY_nBSY_IRQ	PXA_GPIO_TO_IRQ(GPIO27_PRDY_nBSY)
>  
>  /* CF GPIO line modes */
>  #define GPIO4_nSTSCHG_MD		(GPIO4_nSTSCHG | GPIO_IN)
> diff --git a/arch/arm/mach-pxa/include/mach/idp.h b/arch/arm/mach-pxa/include/mach/idp.h
> index 5eff96f..a7f912f 100644
> --- a/arch/arm/mach-pxa/include/mach/idp.h
> +++ b/arch/arm/mach-pxa/include/mach/idp.h
> @@ -135,24 +135,24 @@
>  
>  /* A listing of interrupts used by external hardware devices */
>  
> -#define TOUCH_PANEL_IRQ			IRQ_GPIO(5)
> -#define IDE_IRQ				IRQ_GPIO(21)
> +#define TOUCH_PANEL_IRQ			PXA_GPIO_TO_IRQ(5)
> +#define IDE_IRQ				PXA_GPIO_TO_IRQ(21)
>  
>  #define TOUCH_PANEL_IRQ_EDGE		IRQ_TYPE_EDGE_FALLING
>  
> -#define ETHERNET_IRQ			IRQ_GPIO(4)
> +#define ETHERNET_IRQ			PXA_GPIO_TO_IRQ(4)
>  #define ETHERNET_IRQ_EDGE		IRQ_TYPE_EDGE_RISING
>  
>  #define IDE_IRQ_EDGE			IRQ_TYPE_EDGE_RISING
>  
> -#define PCMCIA_S0_CD_VALID		IRQ_GPIO(7)
> +#define PCMCIA_S0_CD_VALID		PXA_GPIO_TO_IRQ(7)
>  #define PCMCIA_S0_CD_VALID_EDGE		IRQ_TYPE_EDGE_BOTH
>  
> -#define PCMCIA_S1_CD_VALID		IRQ_GPIO(8)
> +#define PCMCIA_S1_CD_VALID		PXA_GPIO_TO_IRQ(8)
>  #define PCMCIA_S1_CD_VALID_EDGE		IRQ_TYPE_EDGE_BOTH
>  
> -#define PCMCIA_S0_RDYINT		IRQ_GPIO(19)
> -#define PCMCIA_S1_RDYINT		IRQ_GPIO(22)
> +#define PCMCIA_S0_RDYINT		PXA_GPIO_TO_IRQ(19)
> +#define PCMCIA_S1_RDYINT		PXA_GPIO_TO_IRQ(22)
>  
>  
>  /*
> diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
> index 7cc5a78..1f99664 100644
> --- a/arch/arm/mach-pxa/include/mach/irqs.h
> +++ b/arch/arm/mach-pxa/include/mach/irqs.h
> @@ -91,7 +91,7 @@
>  #define PXA_GPIO_IRQ_NUM	(192)
>  
>  #define GPIO_2_x_TO_IRQ(x)	(PXA_GPIO_IRQ_BASE + (x))
> -#define IRQ_GPIO(x)	(((x) < 2) ? (IRQ_GPIO0 + (x)) : GPIO_2_x_TO_IRQ(x))
> +#define PXA_GPIO_TO_IRQ(x)	(((x) < 2) ? (IRQ_GPIO0 + (x)) : GPIO_2_x_TO_IRQ(x))
>  
>  /*
>   * The following interrupts are for board specific purposes. Since
> diff --git a/arch/arm/mach-pxa/include/mach/palmld.h b/arch/arm/mach-pxa/include/mach/palmld.h
> index ae536e8..2c44713 100644
> --- a/arch/arm/mach-pxa/include/mach/palmld.h
> +++ b/arch/arm/mach-pxa/include/mach/palmld.h
> @@ -68,10 +68,10 @@
>  /* 20, 53 and 86 are usb related too */
>  
>  /* INTERRUPTS */
> -#define IRQ_GPIO_PALMLD_GPIO_RESET	IRQ_GPIO(GPIO_NR_PALMLD_GPIO_RESET)
> -#define IRQ_GPIO_PALMLD_SD_DETECT_N	IRQ_GPIO(GPIO_NR_PALMLD_SD_DETECT_N)
> -#define IRQ_GPIO_PALMLD_WM9712_IRQ	IRQ_GPIO(GPIO_NR_PALMLD_WM9712_IRQ)
> -#define IRQ_GPIO_PALMLD_IDE_IRQ		IRQ_GPIO(GPIO_NR_PALMLD_IDE_IRQ)
> +#define IRQ_GPIO_PALMLD_GPIO_RESET	PXA_GPIO_TO_IRQ(GPIO_NR_PALMLD_GPIO_RESET)
> +#define IRQ_GPIO_PALMLD_SD_DETECT_N	PXA_GPIO_TO_IRQ(GPIO_NR_PALMLD_SD_DETECT_N)
> +#define IRQ_GPIO_PALMLD_WM9712_IRQ	PXA_GPIO_TO_IRQ(GPIO_NR_PALMLD_WM9712_IRQ)
> +#define IRQ_GPIO_PALMLD_IDE_IRQ		PXA_GPIO_TO_IRQ(GPIO_NR_PALMLD_IDE_IRQ)
>  
>  
>  /** HERE ARE INIT VALUES **/
> diff --git a/arch/arm/mach-pxa/include/mach/palmt5.h b/arch/arm/mach-pxa/include/mach/palmt5.h
> index 6baf746..0bd4f03 100644
> --- a/arch/arm/mach-pxa/include/mach/palmt5.h
> +++ b/arch/arm/mach-pxa/include/mach/palmt5.h
> @@ -48,10 +48,10 @@
>  #define GPIO_NR_PALMT5_BT_RESET			83
>  
>  /* INTERRUPTS */
> -#define IRQ_GPIO_PALMT5_SD_DETECT_N	IRQ_GPIO(GPIO_NR_PALMT5_SD_DETECT_N)
> -#define IRQ_GPIO_PALMT5_WM9712_IRQ	IRQ_GPIO(GPIO_NR_PALMT5_WM9712_IRQ)
> -#define IRQ_GPIO_PALMT5_USB_DETECT	IRQ_GPIO(GPIO_NR_PALMT5_USB_DETECT)
> -#define IRQ_GPIO_PALMT5_GPIO_RESET	IRQ_GPIO(GPIO_NR_PALMT5_GPIO_RESET)
> +#define IRQ_GPIO_PALMT5_SD_DETECT_N	PXA_GPIO_TO_IRQ(GPIO_NR_PALMT5_SD_DETECT_N)
> +#define IRQ_GPIO_PALMT5_WM9712_IRQ	PXA_GPIO_TO_IRQ(GPIO_NR_PALMT5_WM9712_IRQ)
> +#define IRQ_GPIO_PALMT5_USB_DETECT	PXA_GPIO_TO_IRQ(GPIO_NR_PALMT5_USB_DETECT)
> +#define IRQ_GPIO_PALMT5_GPIO_RESET	PXA_GPIO_TO_IRQ(GPIO_NR_PALMT5_GPIO_RESET)
>  
>  /** HERE ARE INIT VALUES **/
>  
> diff --git a/arch/arm/mach-pxa/include/mach/palmtc.h b/arch/arm/mach-pxa/include/mach/palmtc.h
> index 3f9dd3f..c383a21 100644
> --- a/arch/arm/mach-pxa/include/mach/palmtc.h
> +++ b/arch/arm/mach-pxa/include/mach/palmtc.h
> @@ -52,8 +52,8 @@
>  #define GPIO_NR_PALMTC_IR_DISABLE	45
>  
>  /* IRQs */
> -#define IRQ_GPIO_PALMTC_SD_DETECT_N	IRQ_GPIO(GPIO_NR_PALMTC_SD_DETECT_N)
> -#define IRQ_GPIO_PALMTC_WLAN_READY	IRQ_GPIO(GPIO_NR_PALMTC_WLAN_READY)
> +#define IRQ_GPIO_PALMTC_SD_DETECT_N	PXA_GPIO_TO_IRQ(GPIO_NR_PALMTC_SD_DETECT_N)
> +#define IRQ_GPIO_PALMTC_WLAN_READY	PXA_GPIO_TO_IRQ(GPIO_NR_PALMTC_WLAN_READY)
>  
>  /* UCB1400 GPIOs */
>  #define GPIO_NR_PALMTC_POWER_DETECT	(0x80 | 0x00)
> diff --git a/arch/arm/mach-pxa/include/mach/palmtx.h b/arch/arm/mach-pxa/include/mach/palmtx.h
> index 10abc4f..c3b6c72 100644
> --- a/arch/arm/mach-pxa/include/mach/palmtx.h
> +++ b/arch/arm/mach-pxa/include/mach/palmtx.h
> @@ -62,10 +62,10 @@
>  #define GPIO_NR_PALMTX_NAND_BUFFER_DIR		79
>  
>  /* INTERRUPTS */
> -#define IRQ_GPIO_PALMTX_SD_DETECT_N	IRQ_GPIO(GPIO_NR_PALMTX_SD_DETECT_N)
> -#define IRQ_GPIO_PALMTX_WM9712_IRQ	IRQ_GPIO(GPIO_NR_PALMTX_WM9712_IRQ)
> -#define IRQ_GPIO_PALMTX_USB_DETECT	IRQ_GPIO(GPIO_NR_PALMTX_USB_DETECT)
> -#define IRQ_GPIO_PALMTX_GPIO_RESET	IRQ_GPIO(GPIO_NR_PALMTX_GPIO_RESET)
> +#define IRQ_GPIO_PALMTX_SD_DETECT_N	PXA_GPIO_TO_IRQ(GPIO_NR_PALMTX_SD_DETECT_N)
> +#define IRQ_GPIO_PALMTX_WM9712_IRQ	PXA_GPIO_TO_IRQ(GPIO_NR_PALMTX_WM9712_IRQ)
> +#define IRQ_GPIO_PALMTX_USB_DETECT	PXA_GPIO_TO_IRQ(GPIO_NR_PALMTX_USB_DETECT)
> +#define IRQ_GPIO_PALMTX_GPIO_RESET	PXA_GPIO_TO_IRQ(GPIO_NR_PALMTX_GPIO_RESET)
>  
>  /** HERE ARE INIT VALUES **/
>  
> diff --git a/arch/arm/mach-pxa/include/mach/pcm027.h b/arch/arm/mach-pxa/include/mach/pcm027.h
> index 4bac588..6bf28de 100644
> --- a/arch/arm/mach-pxa/include/mach/pcm027.h
> +++ b/arch/arm/mach-pxa/include/mach/pcm027.h
> @@ -34,7 +34,7 @@
>  
>  /* I2C RTC */
>  #define PCM027_RTC_IRQ_GPIO	0
> -#define PCM027_RTC_IRQ		IRQ_GPIO(PCM027_RTC_IRQ_GPIO)
> +#define PCM027_RTC_IRQ		PXA_GPIO_TO_IRQ(PCM027_RTC_IRQ_GPIO)
>  #define PCM027_RTC_IRQ_EDGE	IRQ_TYPE_EDGE_FALLING
>  #define ADR_PCM027_RTC		0x51	/* I2C address */
>  
> @@ -43,21 +43,21 @@
>  
>  /* Ethernet chip (SMSC91C111) */
>  #define PCM027_ETH_IRQ_GPIO	52
> -#define PCM027_ETH_IRQ		IRQ_GPIO(PCM027_ETH_IRQ_GPIO)
> +#define PCM027_ETH_IRQ		PXA_GPIO_TO_IRQ(PCM027_ETH_IRQ_GPIO)
>  #define PCM027_ETH_IRQ_EDGE	IRQ_TYPE_EDGE_RISING
>  #define PCM027_ETH_PHYS		PXA_CS5_PHYS
>  #define PCM027_ETH_SIZE		(1*1024*1024)
>  
>  /* CAN controller SJA1000 (unsupported yet) */
>  #define PCM027_CAN_IRQ_GPIO	114
> -#define PCM027_CAN_IRQ		IRQ_GPIO(PCM027_CAN_IRQ_GPIO)
> +#define PCM027_CAN_IRQ		PXA_GPIO_TO_IRQ(PCM027_CAN_IRQ_GPIO)
>  #define PCM027_CAN_IRQ_EDGE	IRQ_TYPE_EDGE_FALLING
>  #define PCM027_CAN_PHYS		0x22000000
>  #define PCM027_CAN_SIZE		0x100
>  
>  /* SPI GPIO expander (unsupported yet) */
>  #define PCM027_EGPIO_IRQ_GPIO	27
> -#define PCM027_EGPIO_IRQ	IRQ_GPIO(PCM027_EGPIO_IRQ_GPIO)
> +#define PCM027_EGPIO_IRQ	PXA_GPIO_TO_IRQ(PCM027_EGPIO_IRQ_GPIO)
>  #define PCM027_EGPIO_IRQ_EDGE	IRQ_TYPE_EDGE_FALLING
>  #define PCM027_EGPIO_CS		24
>  /*
> diff --git a/arch/arm/mach-pxa/include/mach/pcm990_baseboard.h b/arch/arm/mach-pxa/include/mach/pcm990_baseboard.h
> index 8a4383b..d727916 100644
> --- a/arch/arm/mach-pxa/include/mach/pcm990_baseboard.h
> +++ b/arch/arm/mach-pxa/include/mach/pcm990_baseboard.h
> @@ -28,14 +28,14 @@
>  
>  /* CPLD's interrupt controller is connected to PCM-027 GPIO 9 */
>  #define PCM990_CTRL_INT_IRQ_GPIO	9
> -#define PCM990_CTRL_INT_IRQ		IRQ_GPIO(PCM990_CTRL_INT_IRQ_GPIO)
> +#define PCM990_CTRL_INT_IRQ		PXA_GPIO_TO_IRQ(PCM990_CTRL_INT_IRQ_GPIO)
>  #define PCM990_CTRL_INT_IRQ_EDGE	IRQ_TYPE_EDGE_RISING
>  #define PCM990_CTRL_PHYS		PXA_CS1_PHYS	/* 16-Bit */
>  #define PCM990_CTRL_BASE		0xea000000
>  #define PCM990_CTRL_SIZE		(1*1024*1024)
>  
>  #define PCM990_CTRL_PWR_IRQ_GPIO	14
> -#define PCM990_CTRL_PWR_IRQ		IRQ_GPIO(PCM990_CTRL_PWR_IRQ_GPIO)
> +#define PCM990_CTRL_PWR_IRQ		PXA_GPIO_TO_IRQ(PCM990_CTRL_PWR_IRQ_GPIO)
>  #define PCM990_CTRL_PWR_IRQ_EDGE	IRQ_TYPE_EDGE_RISING
>  
>  /* visible CPLD (U7) registers */
> @@ -132,7 +132,7 @@
>   * IDE
>   */
>  #define PCM990_IDE_IRQ_GPIO	13
> -#define PCM990_IDE_IRQ		IRQ_GPIO(PCM990_IDE_IRQ_GPIO)
> +#define PCM990_IDE_IRQ		PXA_GPIO_TO_IRQ(PCM990_IDE_IRQ_GPIO)
>  #define PCM990_IDE_IRQ_EDGE	IRQ_TYPE_EDGE_RISING
>  #define PCM990_IDE_PLD_PHYS	0x20000000	/* 16 bit wide */
>  #define PCM990_IDE_PLD_BASE	0xee000000
> @@ -188,11 +188,11 @@
>   * Compact Flash
>   */
>  #define PCM990_CF_IRQ_GPIO	11
> -#define PCM990_CF_IRQ		IRQ_GPIO(PCM990_CF_IRQ_GPIO)
> +#define PCM990_CF_IRQ		PXA_GPIO_TO_IRQ(PCM990_CF_IRQ_GPIO)
>  #define PCM990_CF_IRQ_EDGE	IRQ_TYPE_EDGE_RISING
>  
>  #define PCM990_CF_CD_GPIO	12
> -#define PCM990_CF_CD		IRQ_GPIO(PCM990_CF_CD_GPIO)
> +#define PCM990_CF_CD		PXA_GPIO_TO_IRQ(PCM990_CF_CD_GPIO)
>  #define PCM990_CF_CD_EDGE	IRQ_TYPE_EDGE_RISING
>  
>  #define PCM990_CF_PLD_PHYS	0x30000000	/* 16 bit wide */
> @@ -258,14 +258,14 @@
>   * Wolfson AC97 Touch
>   */
>  #define PCM990_AC97_IRQ_GPIO	10
> -#define PCM990_AC97_IRQ		IRQ_GPIO(PCM990_AC97_IRQ_GPIO)
> +#define PCM990_AC97_IRQ		PXA_GPIO_TO_IRQ(PCM990_AC97_IRQ_GPIO)
>  #define PCM990_AC97_IRQ_EDGE	IRQ_TYPE_EDGE_RISING
>  
>  /*
>   * MMC phyCORE
>   */
>  #define PCM990_MMC0_IRQ_GPIO	9
> -#define PCM990_MMC0_IRQ		IRQ_GPIO(PCM990_MMC0_IRQ_GPIO)
> +#define PCM990_MMC0_IRQ		PXA_GPIO_TO_IRQ(PCM990_MMC0_IRQ_GPIO)
>  #define PCM990_MMC0_IRQ_EDGE	IRQ_TYPE_EDGE_FALLING
>  
>  /*
> diff --git a/arch/arm/mach-pxa/include/mach/poodle.h b/arch/arm/mach-pxa/include/mach/poodle.h
> index 83d1cfd..763fdc4 100644
> --- a/arch/arm/mach-pxa/include/mach/poodle.h
> +++ b/arch/arm/mach-pxa/include/mach/poodle.h
> @@ -47,18 +47,18 @@
>  #define POODLE_GPIO_DISCHARGE_ON        (42) /* Enable battery discharge */
>  
>  /* PXA GPIOs */
> -#define POODLE_IRQ_GPIO_ON_KEY		IRQ_GPIO(0)
> -#define POODLE_IRQ_GPIO_AC_IN		IRQ_GPIO(1)
> -#define POODLE_IRQ_GPIO_HP_IN		IRQ_GPIO(4)
> -#define POODLE_IRQ_GPIO_CO		IRQ_GPIO(16)
> -#define POODLE_IRQ_GPIO_TP_INT		IRQ_GPIO(5)
> -#define POODLE_IRQ_GPIO_WAKEUP		IRQ_GPIO(11)
> -#define POODLE_IRQ_GPIO_GA_INT		IRQ_GPIO(10)
> -#define POODLE_IRQ_GPIO_CF_IRQ		IRQ_GPIO(17)
> -#define POODLE_IRQ_GPIO_CF_CD		IRQ_GPIO(14)
> -#define POODLE_IRQ_GPIO_nSD_INT		IRQ_GPIO(8)
> -#define POODLE_IRQ_GPIO_nSD_DETECT	IRQ_GPIO(9)
> -#define POODLE_IRQ_GPIO_MAIN_BAT_LOW	IRQ_GPIO(13)
> +#define POODLE_IRQ_GPIO_ON_KEY		PXA_GPIO_TO_IRQ(0)
> +#define POODLE_IRQ_GPIO_AC_IN		PXA_GPIO_TO_IRQ(1)
> +#define POODLE_IRQ_GPIO_HP_IN		PXA_GPIO_TO_IRQ(4)
> +#define POODLE_IRQ_GPIO_CO		PXA_GPIO_TO_IRQ(16)
> +#define POODLE_IRQ_GPIO_TP_INT		PXA_GPIO_TO_IRQ(5)
> +#define POODLE_IRQ_GPIO_WAKEUP		PXA_GPIO_TO_IRQ(11)
> +#define POODLE_IRQ_GPIO_GA_INT		PXA_GPIO_TO_IRQ(10)
> +#define POODLE_IRQ_GPIO_CF_IRQ		PXA_GPIO_TO_IRQ(17)
> +#define POODLE_IRQ_GPIO_CF_CD		PXA_GPIO_TO_IRQ(14)
> +#define POODLE_IRQ_GPIO_nSD_INT		PXA_GPIO_TO_IRQ(8)
> +#define POODLE_IRQ_GPIO_nSD_DETECT	PXA_GPIO_TO_IRQ(9)
> +#define POODLE_IRQ_GPIO_MAIN_BAT_LOW	PXA_GPIO_TO_IRQ(13)
>  
>  /* SCOOP GPIOs */
>  #define POODLE_SCOOP_CHARGE_ON	SCOOP_GPCR_PA11
> diff --git a/arch/arm/mach-pxa/include/mach/spitz.h b/arch/arm/mach-pxa/include/mach/spitz.h
> index 685749a..273381a 100644
> --- a/arch/arm/mach-pxa/include/mach/spitz.h
> +++ b/arch/arm/mach-pxa/include/mach/spitz.h
> @@ -164,23 +164,23 @@
>  
>  /* Spitz IRQ Definitions */
>  
> -#define SPITZ_IRQ_GPIO_KEY_INT        IRQ_GPIO(SPITZ_GPIO_KEY_INT)
> -#define SPITZ_IRQ_GPIO_AC_IN          IRQ_GPIO(SPITZ_GPIO_AC_IN)
> -#define SPITZ_IRQ_GPIO_AK_INT         IRQ_GPIO(SPITZ_GPIO_AK_INT)
> -#define SPITZ_IRQ_GPIO_HP_IN          IRQ_GPIO(SPITZ_GPIO_HP_IN)
> -#define SPITZ_IRQ_GPIO_TP_INT         IRQ_GPIO(SPITZ_GPIO_TP_INT)
> -#define SPITZ_IRQ_GPIO_SYNC           IRQ_GPIO(SPITZ_GPIO_SYNC)
> -#define SPITZ_IRQ_GPIO_ON_KEY         IRQ_GPIO(SPITZ_GPIO_ON_KEY)
> -#define SPITZ_IRQ_GPIO_SWA            IRQ_GPIO(SPITZ_GPIO_SWA)
> -#define SPITZ_IRQ_GPIO_SWB            IRQ_GPIO(SPITZ_GPIO_SWB)
> -#define SPITZ_IRQ_GPIO_BAT_COVER      IRQ_GPIO(SPITZ_GPIO_BAT_COVER)
> -#define SPITZ_IRQ_GPIO_FATAL_BAT      IRQ_GPIO(SPITZ_GPIO_FATAL_BAT)
> -#define SPITZ_IRQ_GPIO_CO             IRQ_GPIO(SPITZ_GPIO_CO)
> -#define SPITZ_IRQ_GPIO_CF_IRQ         IRQ_GPIO(SPITZ_GPIO_CF_IRQ)
> -#define SPITZ_IRQ_GPIO_CF_CD          IRQ_GPIO(SPITZ_GPIO_CF_CD)
> -#define SPITZ_IRQ_GPIO_CF2_IRQ        IRQ_GPIO(SPITZ_GPIO_CF2_IRQ)
> -#define SPITZ_IRQ_GPIO_nSD_INT        IRQ_GPIO(SPITZ_GPIO_nSD_INT)
> -#define SPITZ_IRQ_GPIO_nSD_DETECT     IRQ_GPIO(SPITZ_GPIO_nSD_DETECT)
> +#define SPITZ_IRQ_GPIO_KEY_INT        PXA_GPIO_TO_IRQ(SPITZ_GPIO_KEY_INT)
> +#define SPITZ_IRQ_GPIO_AC_IN          PXA_GPIO_TO_IRQ(SPITZ_GPIO_AC_IN)
> +#define SPITZ_IRQ_GPIO_AK_INT         PXA_GPIO_TO_IRQ(SPITZ_GPIO_AK_INT)
> +#define SPITZ_IRQ_GPIO_HP_IN          PXA_GPIO_TO_IRQ(SPITZ_GPIO_HP_IN)
> +#define SPITZ_IRQ_GPIO_TP_INT         PXA_GPIO_TO_IRQ(SPITZ_GPIO_TP_INT)
> +#define SPITZ_IRQ_GPIO_SYNC           PXA_GPIO_TO_IRQ(SPITZ_GPIO_SYNC)
> +#define SPITZ_IRQ_GPIO_ON_KEY         PXA_GPIO_TO_IRQ(SPITZ_GPIO_ON_KEY)
> +#define SPITZ_IRQ_GPIO_SWA            PXA_GPIO_TO_IRQ(SPITZ_GPIO_SWA)
> +#define SPITZ_IRQ_GPIO_SWB            PXA_GPIO_TO_IRQ(SPITZ_GPIO_SWB)
> +#define SPITZ_IRQ_GPIO_BAT_COVER      PXA_GPIO_TO_IRQ(SPITZ_GPIO_BAT_COVER)
> +#define SPITZ_IRQ_GPIO_FATAL_BAT      PXA_GPIO_TO_IRQ(SPITZ_GPIO_FATAL_BAT)
> +#define SPITZ_IRQ_GPIO_CO             PXA_GPIO_TO_IRQ(SPITZ_GPIO_CO)
> +#define SPITZ_IRQ_GPIO_CF_IRQ         PXA_GPIO_TO_IRQ(SPITZ_GPIO_CF_IRQ)
> +#define SPITZ_IRQ_GPIO_CF_CD          PXA_GPIO_TO_IRQ(SPITZ_GPIO_CF_CD)
> +#define SPITZ_IRQ_GPIO_CF2_IRQ        PXA_GPIO_TO_IRQ(SPITZ_GPIO_CF2_IRQ)
> +#define SPITZ_IRQ_GPIO_nSD_INT        PXA_GPIO_TO_IRQ(SPITZ_GPIO_nSD_INT)
> +#define SPITZ_IRQ_GPIO_nSD_DETECT     PXA_GPIO_TO_IRQ(SPITZ_GPIO_nSD_DETECT)
>  
>  /*
>   * Shared data structures
> diff --git a/arch/arm/mach-pxa/include/mach/tosa.h b/arch/arm/mach-pxa/include/mach/tosa.h
> index 1272c4b..4653539 100644
> --- a/arch/arm/mach-pxa/include/mach/tosa.h
> +++ b/arch/arm/mach-pxa/include/mach/tosa.h
> @@ -141,30 +141,30 @@
>  /*
>   * Interrupts
>   */
> -#define TOSA_IRQ_GPIO_WAKEUP        	IRQ_GPIO(TOSA_GPIO_WAKEUP)
> -#define TOSA_IRQ_GPIO_AC_IN         	IRQ_GPIO(TOSA_GPIO_AC_IN)
> -#define TOSA_IRQ_GPIO_RECORD_BTN    	IRQ_GPIO(TOSA_GPIO_RECORD_BTN)
> -#define TOSA_IRQ_GPIO_SYNC          	IRQ_GPIO(TOSA_GPIO_SYNC)
> -#define TOSA_IRQ_GPIO_USB_IN        	IRQ_GPIO(TOSA_GPIO_USB_IN)
> -#define TOSA_IRQ_GPIO_JACKET_DETECT 	IRQ_GPIO(TOSA_GPIO_JACKET_DETECT)
> -#define TOSA_IRQ_GPIO_nSD_INT       	IRQ_GPIO(TOSA_GPIO_nSD_INT)
> -#define TOSA_IRQ_GPIO_nSD_DETECT    	IRQ_GPIO(TOSA_GPIO_nSD_DETECT)
> -#define TOSA_IRQ_GPIO_BAT1_CRG      	IRQ_GPIO(TOSA_GPIO_BAT1_CRG)
> -#define TOSA_IRQ_GPIO_CF_CD         	IRQ_GPIO(TOSA_GPIO_CF_CD)
> -#define TOSA_IRQ_GPIO_BAT0_CRG      	IRQ_GPIO(TOSA_GPIO_BAT0_CRG)
> -#define TOSA_IRQ_GPIO_TC6393XB_INT    	IRQ_GPIO(TOSA_GPIO_TC6393XB_INT)
> -#define TOSA_IRQ_GPIO_BAT0_LOW      	IRQ_GPIO(TOSA_GPIO_BAT0_LOW)
> -#define TOSA_IRQ_GPIO_EAR_IN        	IRQ_GPIO(TOSA_GPIO_EAR_IN)
> -#define TOSA_IRQ_GPIO_CF_IRQ        	IRQ_GPIO(TOSA_GPIO_CF_IRQ)
> -#define TOSA_IRQ_GPIO_ON_KEY        	IRQ_GPIO(TOSA_GPIO_ON_KEY)
> -#define TOSA_IRQ_GPIO_VGA_LINE      	IRQ_GPIO(TOSA_GPIO_VGA_LINE)
> -#define TOSA_IRQ_GPIO_TP_INT        	IRQ_GPIO(TOSA_GPIO_TP_INT)
> -#define TOSA_IRQ_GPIO_JC_CF_IRQ     	IRQ_GPIO(TOSA_GPIO_JC_CF_IRQ)
> -#define TOSA_IRQ_GPIO_BAT_LOCKED    	IRQ_GPIO(TOSA_GPIO_BAT_LOCKED)
> -#define TOSA_IRQ_GPIO_BAT1_LOW      	IRQ_GPIO(TOSA_GPIO_BAT1_LOW)
> -#define TOSA_IRQ_GPIO_KEY_SENSE(a)  	IRQ_GPIO(69+(a))
> -
> -#define TOSA_IRQ_GPIO_MAIN_BAT_LOW 	IRQ_GPIO(TOSA_GPIO_MAIN_BAT_LOW)
> +#define TOSA_IRQ_GPIO_WAKEUP        	PXA_GPIO_TO_IRQ(TOSA_GPIO_WAKEUP)
> +#define TOSA_IRQ_GPIO_AC_IN         	PXA_GPIO_TO_IRQ(TOSA_GPIO_AC_IN)
> +#define TOSA_IRQ_GPIO_RECORD_BTN    	PXA_GPIO_TO_IRQ(TOSA_GPIO_RECORD_BTN)
> +#define TOSA_IRQ_GPIO_SYNC          	PXA_GPIO_TO_IRQ(TOSA_GPIO_SYNC)
> +#define TOSA_IRQ_GPIO_USB_IN        	PXA_GPIO_TO_IRQ(TOSA_GPIO_USB_IN)
> +#define TOSA_IRQ_GPIO_JACKET_DETECT 	PXA_GPIO_TO_IRQ(TOSA_GPIO_JACKET_DETECT)
> +#define TOSA_IRQ_GPIO_nSD_INT       	PXA_GPIO_TO_IRQ(TOSA_GPIO_nSD_INT)
> +#define TOSA_IRQ_GPIO_nSD_DETECT    	PXA_GPIO_TO_IRQ(TOSA_GPIO_nSD_DETECT)
> +#define TOSA_IRQ_GPIO_BAT1_CRG      	PXA_GPIO_TO_IRQ(TOSA_GPIO_BAT1_CRG)
> +#define TOSA_IRQ_GPIO_CF_CD         	PXA_GPIO_TO_IRQ(TOSA_GPIO_CF_CD)
> +#define TOSA_IRQ_GPIO_BAT0_CRG      	PXA_GPIO_TO_IRQ(TOSA_GPIO_BAT0_CRG)
> +#define TOSA_IRQ_GPIO_TC6393XB_INT    	PXA_GPIO_TO_IRQ(TOSA_GPIO_TC6393XB_INT)
> +#define TOSA_IRQ_GPIO_BAT0_LOW      	PXA_GPIO_TO_IRQ(TOSA_GPIO_BAT0_LOW)
> +#define TOSA_IRQ_GPIO_EAR_IN        	PXA_GPIO_TO_IRQ(TOSA_GPIO_EAR_IN)
> +#define TOSA_IRQ_GPIO_CF_IRQ        	PXA_GPIO_TO_IRQ(TOSA_GPIO_CF_IRQ)
> +#define TOSA_IRQ_GPIO_ON_KEY        	PXA_GPIO_TO_IRQ(TOSA_GPIO_ON_KEY)
> +#define TOSA_IRQ_GPIO_VGA_LINE      	PXA_GPIO_TO_IRQ(TOSA_GPIO_VGA_LINE)
> +#define TOSA_IRQ_GPIO_TP_INT        	PXA_GPIO_TO_IRQ(TOSA_GPIO_TP_INT)
> +#define TOSA_IRQ_GPIO_JC_CF_IRQ     	PXA_GPIO_TO_IRQ(TOSA_GPIO_JC_CF_IRQ)
> +#define TOSA_IRQ_GPIO_BAT_LOCKED    	PXA_GPIO_TO_IRQ(TOSA_GPIO_BAT_LOCKED)
> +#define TOSA_IRQ_GPIO_BAT1_LOW      	PXA_GPIO_TO_IRQ(TOSA_GPIO_BAT1_LOW)
> +#define TOSA_IRQ_GPIO_KEY_SENSE(a)  	PXA_GPIO_TO_IRQ(69+(a))
> +
> +#define TOSA_IRQ_GPIO_MAIN_BAT_LOW 	PXA_GPIO_TO_IRQ(TOSA_GPIO_MAIN_BAT_LOW)
>  
>  #define TOSA_KEY_SYNC		KEY_102ND /* ??? */
>  
> diff --git a/arch/arm/mach-pxa/include/mach/trizeps4.h b/arch/arm/mach-pxa/include/mach/trizeps4.h
> index 903e1a2..d2ca010 100644
> --- a/arch/arm/mach-pxa/include/mach/trizeps4.h
> +++ b/arch/arm/mach-pxa/include/mach/trizeps4.h
> @@ -43,30 +43,30 @@
>  
>  /* Ethernet Controller Davicom DM9000 */
>  #define GPIO_DM9000		101
> -#define TRIZEPS4_ETH_IRQ	IRQ_GPIO(GPIO_DM9000)
> +#define TRIZEPS4_ETH_IRQ	PXA_GPIO_TO_IRQ(GPIO_DM9000)
>  
>  /* UCB1400 audio / TS-controller */
>  #define GPIO_UCB1400		1
> -#define TRIZEPS4_UCB1400_IRQ	IRQ_GPIO(GPIO_UCB1400)
> +#define TRIZEPS4_UCB1400_IRQ	PXA_GPIO_TO_IRQ(GPIO_UCB1400)
>  
>  /* PCMCIA socket Compact Flash */
>  #define GPIO_PCD		11		/* PCMCIA Card Detect */
> -#define TRIZEPS4_CD_IRQ		IRQ_GPIO(GPIO_PCD)
> +#define TRIZEPS4_CD_IRQ		PXA_GPIO_TO_IRQ(GPIO_PCD)
>  #define GPIO_PRDY		13		/* READY / nINT */
> -#define TRIZEPS4_READY_NINT	IRQ_GPIO(GPIO_PRDY)
> +#define TRIZEPS4_READY_NINT	PXA_GPIO_TO_IRQ(GPIO_PRDY)
>  
>  /* MMC socket */
>  #define GPIO_MMC_DET		12
> -#define TRIZEPS4_MMC_IRQ	IRQ_GPIO(GPIO_MMC_DET)
> +#define TRIZEPS4_MMC_IRQ	PXA_GPIO_TO_IRQ(GPIO_MMC_DET)
>  
>  /* DOC NAND chip */
>  #define GPIO_DOC_LOCK           94
>  #define GPIO_DOC_IRQ            93
> -#define TRIZEPS4_DOC_IRQ        IRQ_GPIO(GPIO_DOC_IRQ)
> +#define TRIZEPS4_DOC_IRQ        PXA_GPIO_TO_IRQ(GPIO_DOC_IRQ)
>  
>  /* SPI interface */
>  #define GPIO_SPI                53
> -#define TRIZEPS4_SPI_IRQ        IRQ_GPIO(GPIO_SPI)
> +#define TRIZEPS4_SPI_IRQ        PXA_GPIO_TO_IRQ(GPIO_SPI)
>  
>  /* LEDS using tx2 / rx2 */
>  #define GPIO_SYS_BUSY_LED	46
> @@ -74,7 +74,7 @@
>  
>  /* Off-module PIC on ConXS board */
>  #define GPIO_PIC		0
> -#define TRIZEPS4_PIC_IRQ	IRQ_GPIO(GPIO_PIC)
> +#define TRIZEPS4_PIC_IRQ	PXA_GPIO_TO_IRQ(GPIO_PIC)
>  
>  #ifdef CONFIG_MACH_TRIZEPS_CONXS
>  /* for CONXS base board define these registers */
> diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
> index 0037e57..9cd2356 100644
> --- a/arch/arm/mach-pxa/littleton.c
> +++ b/arch/arm/mach-pxa/littleton.c
> @@ -124,8 +124,8 @@ static struct resource smc91x_resources[] = {
>  		.flags	= IORESOURCE_MEM,
>  	},
>  	[1] = {
> -		.start	= IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO90)),
> -		.end	= IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO90)),
> +		.start	= PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO90)),
> +		.end	= PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO90)),
>  		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE,
>  	}
>  };
> diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
> index 64540d9..60c49f1 100644
> --- a/arch/arm/mach-pxa/lpd270.c
> +++ b/arch/arm/mach-pxa/lpd270.c
> @@ -152,8 +152,8 @@ static void __init lpd270_init_irq(void)
>  					 handle_level_irq);
>  		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
>  	}
> -	irq_set_chained_handler(IRQ_GPIO(0), lpd270_irq_handler);
> -	irq_set_irq_type(IRQ_GPIO(0), IRQ_TYPE_EDGE_FALLING);
> +	irq_set_chained_handler(PXA_GPIO_TO_IRQ(0), lpd270_irq_handler);
> +	irq_set_irq_type(PXA_GPIO_TO_IRQ(0), IRQ_TYPE_EDGE_FALLING);
>  }
>  
>  
> diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
> index c48ce6d..2fb2b50 100644
> --- a/arch/arm/mach-pxa/lubbock.c
> +++ b/arch/arm/mach-pxa/lubbock.c
> @@ -170,8 +170,8 @@ static void __init lubbock_init_irq(void)
>  		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
>  	}
>  
> -	irq_set_chained_handler(IRQ_GPIO(0), lubbock_irq_handler);
> -	irq_set_irq_type(IRQ_GPIO(0), IRQ_TYPE_EDGE_FALLING);
> +	irq_set_chained_handler(PXA_GPIO_TO_IRQ(0), lubbock_irq_handler);
> +	irq_set_irq_type(PXA_GPIO_TO_IRQ(0), IRQ_TYPE_EDGE_FALLING);
>  }
>  
>  #ifdef CONFIG_PM
> diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
> index 0567d39..ea62a99 100644
> --- a/arch/arm/mach-pxa/mainstone.c
> +++ b/arch/arm/mach-pxa/mainstone.c
> @@ -178,8 +178,8 @@ static void __init mainstone_init_irq(void)
>  	MST_INTMSKENA = 0;
>  	MST_INTSETCLR = 0;
>  
> -	irq_set_chained_handler(IRQ_GPIO(0), mainstone_irq_handler);
> -	irq_set_irq_type(IRQ_GPIO(0), IRQ_TYPE_EDGE_FALLING);
> +	irq_set_chained_handler(PXA_GPIO_TO_IRQ(0), mainstone_irq_handler);
> +	irq_set_irq_type(PXA_GPIO_TO_IRQ(0), IRQ_TYPE_EDGE_FALLING);
>  }
>  
>  #ifdef CONFIG_PM
> diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
> index 948ce3e..7c8a308 100644
> --- a/arch/arm/mach-pxa/poodle.c
> +++ b/arch/arm/mach-pxa/poodle.c
> @@ -165,8 +165,8 @@ static struct resource locomo_resources[] = {
>  		.flags		= IORESOURCE_MEM,
>  	},
>  	[1] = {
> -		.start		= IRQ_GPIO(10),
> -		.end		= IRQ_GPIO(10),
> +		.start		= PXA_GPIO_TO_IRQ(10),
> +		.end		= PXA_GPIO_TO_IRQ(10),
>  		.flags		= IORESOURCE_IRQ,
>  	},
>  };
> diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
> index 785880f..8d5168d 100644
> --- a/arch/arm/mach-pxa/sharpsl_pm.c
> +++ b/arch/arm/mach-pxa/sharpsl_pm.c
> @@ -907,24 +907,24 @@ static int __devinit sharpsl_pm_probe(struct platform_device *pdev)
>  	gpio_direction_input(sharpsl_pm.machinfo->gpio_batlock);
>  
>  	/* Register interrupt handlers */
> -	if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr, IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING, "AC Input Detect", sharpsl_ac_isr)) {
> -		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin));
> +	if (request_irq(PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr, IRQF_DISABLED | IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING, "AC Input Detect", sharpsl_ac_isr)) {
> +		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_acin));
>  	}
>  
> -	if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr, IRQF_DISABLED | IRQF_TRIGGER_FALLING, "Battery Cover", sharpsl_fatal_isr)) {
> -		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock));
> +	if (request_irq(PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr, IRQF_DISABLED | IRQF_TRIGGER_FALLING, "Battery Cover", sharpsl_fatal_isr)) {
> +		dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_batlock));
>  	}
>  
>  	if (sharpsl_pm.machinfo->gpio_fatal) {
> -		if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr, IRQF_DISABLED | IRQF_TRIGGER_FALLING, "Fatal Battery", sharpsl_fatal_isr)) {
> -			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal));
> +		if (request_irq(PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr, IRQF_DISABLED | IRQF_TRIGGER_FALLING, "Fatal Battery", sharpsl_fatal_isr)) {
> +			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_fatal));
>  		}
>  	}
>  
>  	if (sharpsl_pm.machinfo->batfull_irq) {
>  		/* Register interrupt handler. */
> -		if (request_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr, IRQF_DISABLED | IRQF_TRIGGER_RISING, "CO", sharpsl_chrg_full_isr)) {
> -			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull));
> +		if (request_irq(PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr, IRQF_DISABLED | IRQF_TRIGGER_RISING, "CO", sharpsl_chrg_full_isr)) {
> +			dev_err(sharpsl_pm.dev, "Could not get irq %d.\n", PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_batfull));
>  		}
>  	}
>  
> @@ -953,14 +953,14 @@ static int sharpsl_pm_remove(struct platform_device *pdev)
>  
>  	led_trigger_unregister_simple(sharpsl_charge_led_trigger);
>  
> -	free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr);
> -	free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr);
> +	free_irq(PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_acin), sharpsl_ac_isr);
> +	free_irq(PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_batlock), sharpsl_fatal_isr);
>  
>  	if (sharpsl_pm.machinfo->gpio_fatal)
> -		free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr);
> +		free_irq(PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_fatal), sharpsl_fatal_isr);
>  
>  	if (sharpsl_pm.machinfo->batfull_irq)
> -		free_irq(IRQ_GPIO(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr);
> +		free_irq(PXA_GPIO_TO_IRQ(sharpsl_pm.machinfo->gpio_batfull), sharpsl_chrg_full_isr);
>  
>  	gpio_free(sharpsl_pm.machinfo->gpio_batlock);
>  	gpio_free(sharpsl_pm.machinfo->gpio_batfull);
> diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
> index 4c9a48b..bbf79d5 100644
> --- a/arch/arm/mach-pxa/stargate2.c
> +++ b/arch/arm/mach-pxa/stargate2.c
> @@ -376,7 +376,7 @@ static struct spi_board_info spi_board_info[] __initdata = {
>  		.bus_num = 1,
>  		.chip_select = 0,
>  		.controller_data = &staccel_chip_info,
> -		.irq = IRQ_GPIO(96),
> +		.irq = PXA_GPIO_TO_IRQ(96),
>  	}, {
>  		.modalias = "cc2420",
>  		.max_speed_hz = 6500000,
> @@ -560,18 +560,18 @@ static struct i2c_board_info __initdata imote2_i2c_board_info[] = {
>  		/* Through a nand gate - Also beware, on V2 sensor board the
>  		 * pull up resistors are missing.
>  		 */
> -		.irq = IRQ_GPIO(99),
> +		.irq = PXA_GPIO_TO_IRQ(99),
>  	}, { /* ITS400 Sensor board only */
>  		.type = "tsl2561",
>  		.addr = 0x49,
>  		/* Through a nand gate - Also beware, on V2 sensor board the
>  		 * pull up resistors are missing.
>  		 */
> -		.irq = IRQ_GPIO(99),
> +		.irq = PXA_GPIO_TO_IRQ(99),
>  	}, { /* ITS400 Sensor board only */
>  		.type = "tmp175",
>  		.addr = 0x4A,
> -		.irq = IRQ_GPIO(96),
> +		.irq = PXA_GPIO_TO_IRQ(96),
>  	}, { /* IMB400 Multimedia board */
>  		.type = "wm8940",
>  		.addr = 0x1A,
> @@ -661,8 +661,8 @@ static struct resource smc91x_resources[] = {
>  		.flags = IORESOURCE_MEM,
>  	},
>  	[1] = {
> -		.start = IRQ_GPIO(40),
> -		.end = IRQ_GPIO(40),
> +		.start = PXA_GPIO_TO_IRQ(40),
> +		.end = PXA_GPIO_TO_IRQ(40),
>  		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
>  	}
>  };
> @@ -707,7 +707,7 @@ static int stargate2_mci_init(struct device *dev,
>  	}
>  	gpio_direction_input(SG2_GPIO_nSD_DETECT);
>  
> -	err = request_irq(IRQ_GPIO(SG2_GPIO_nSD_DETECT),
> +	err = request_irq(PXA_GPIO_TO_IRQ(SG2_GPIO_nSD_DETECT),
>  			  stargate2_detect_int,
>  			  IRQ_TYPE_EDGE_BOTH,
>  			  "MMC card detect",
> @@ -738,7 +738,7 @@ static void stargate2_mci_setpower(struct device *dev, unsigned int vdd)
>  
>  static void stargate2_mci_exit(struct device *dev, void *data)
>  {
> -	free_irq(IRQ_GPIO(SG2_GPIO_nSD_DETECT), data);
> +	free_irq(PXA_GPIO_TO_IRQ(SG2_GPIO_nSD_DETECT), data);
>  	gpio_free(SG2_SD_POWER_ENABLE);
>  	gpio_free(SG2_GPIO_nSD_DETECT);
>  }
> @@ -938,18 +938,18 @@ static struct i2c_board_info __initdata stargate2_i2c_board_info[] = {
>  		/* Through a nand gate - Also beware, on V2 sensor board the
>  		 * pull up resistors are missing.
>  		 */
> -		.irq = IRQ_GPIO(99),
> +		.irq = PXA_GPIO_TO_IRQ(99),
>  	}, { /* ITS400 Sensor board only */
>  		.type = "tsl2561",
>  		.addr = 0x49,
>  		/* Through a nand gate - Also beware, on V2 sensor board the
>  		 * pull up resistors are missing.
>  		 */
> -		.irq = IRQ_GPIO(99),
> +		.irq = PXA_GPIO_TO_IRQ(99),
>  	}, { /* ITS400 Sensor board only */
>  		.type = "tmp175",
>  		.addr = 0x4A,
> -		.irq = IRQ_GPIO(96),
> +		.irq = PXA_GPIO_TO_IRQ(96),
>  	},
>  };
>  
> diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
> index a7539a6..585e4f4 100644
> --- a/arch/arm/mach-pxa/vpac270.c
> +++ b/arch/arm/mach-pxa/vpac270.c
> @@ -395,8 +395,8 @@ static struct resource vpac270_dm9000_resources[] = {
>  		.flags	= IORESOURCE_MEM,
>  	},
>  	[2] = {
> -		.start	= IRQ_GPIO(GPIO114_VPAC270_ETH_IRQ),
> -		.end	= IRQ_GPIO(GPIO114_VPAC270_ETH_IRQ),
> +		.start	= PXA_GPIO_TO_IRQ(GPIO114_VPAC270_ETH_IRQ),
> +		.end	= PXA_GPIO_TO_IRQ(GPIO114_VPAC270_ETH_IRQ),
>  		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
>  	},
>  };
> @@ -433,7 +433,7 @@ static pxa2xx_audio_ops_t vpac270_ac97_pdata = {
>  };
>  
>  static struct ucb1400_pdata vpac270_ucb1400_pdata = {
> -	.irq		= IRQ_GPIO(GPIO113_VPAC270_TS_IRQ),
> +	.irq		= PXA_GPIO_TO_IRQ(GPIO113_VPAC270_TS_IRQ),
>  };
>  
>  static struct platform_device vpac270_ucb1400_device = {
> diff --git a/arch/arm/mach-pxa/zylonite_pxa300.c b/arch/arm/mach-pxa/zylonite_pxa300.c
> index 93c64d8..86e59c0 100644
> --- a/arch/arm/mach-pxa/zylonite_pxa300.c
> +++ b/arch/arm/mach-pxa/zylonite_pxa300.c
> @@ -231,12 +231,12 @@ static struct i2c_board_info zylonite_i2c_board_info[] = {
>  		.type		= "pca9539",
>  		.addr		= 0x74,
>  		.platform_data	= &gpio_exp[0],
> -		.irq		= IRQ_GPIO(18),
> +		.irq		= PXA_GPIO_TO_IRQ(18),
>  	}, {
>  		.type		= "pca9539",
>  		.addr		= 0x75,
>  		.platform_data	= &gpio_exp[1],
> -		.irq		= IRQ_GPIO(19),
> +		.irq		= PXA_GPIO_TO_IRQ(19),
>  	},
>  };
>  
> -- 
> 1.7.2.5
> 
