From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Oct 2010 12:00:52 +0200
Subject: [patch 3/9] imx51: enhance/fix iomux configuration
In-Reply-To: <20101019205254.232673283@rtp-net.org>
References: <20101019204253.162641893@rtp-net.org>
	<20101019205254.232673283@rtp-net.org>
Message-ID: <20101020100052.GM28166@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 10:42:56PM +0200, Arnaud Patard wrote:
> - ALT0 is used to set GPIO mode of GPIO_1_{2,3,4,5,6,7,8,9} but it's ALT1
> for GPIO_1_{0,1}.
> - add definition to configure pads as ESDHC{1,2} WP and CD
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Index: linux-2.6/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> ===================================================================
> --- linux-2.6.orig/arch/arm/plat-mxc/include/mach/iomux-mx51.h	2010-10-16 22:22:06.000000000 +0200
> +++ linux-2.6/arch/arm/plat-mxc/include/mach/iomux-mx51.h	2010-10-16 22:23:22.000000000 +0200
> @@ -366,20 +366,24 @@
>  							MX51_SDHCI_PAD_CTRL)
>  #define MX51_PAD_SD2_DATA3__SD2_DATA3		IOMUX_PAD(0x7D0, 0x3C8, IOMUX_CONFIG_SION, 0x0, 0, \
>  							MX51_SDHCI_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_0__ESDHC1_CD		IOMUX_PAD(0x7B4, 0x3AC, 0, 0x0,   0, MX51_I2C_PAD_CTRL)
Is MX51_I2C_PAD_CTRL correct?  ditto for MX51_PAD_GPIO_1_1__ESDHC1_WP.

>  #define MX51_PAD_GPIO_1_0__GPIO_1_0		IOMUX_PAD(0x7B4, 0x3AC, 1, 0x0,   0, MX51_GPIO_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_1__ESDHC1_WP		IOMUX_PAD(0x7B8, 0x3B0, 0, 0x0,   0, MX51_I2C_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_1__GPIO_1_1		IOMUX_PAD(0x7B8, 0x3B0, 1, 0x0,   0, MX51_GPIO_PAD_CTRL)
> -#define MX51_PAD_GPIO_1_2__GPIO_1_2		IOMUX_PAD(0x7D4, 0x3CC, 1, 0x0,   0, MX51_GPIO_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_2__GPIO_1_2		IOMUX_PAD(0x7D4, 0x3CC, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_2__I2C2_SCL		IOMUX_PAD(0x7D4, 0x3CC, (2 | IOMUX_CONFIG_SION), \
>  							0x9b8,   3, MX51_I2C_PAD_CTRL)
> -#define MX51_PAD_GPIO_1_3__GPIO_1_3		IOMUX_PAD(0x7D8, 0x3D0, 1, 0x0,   0, MX51_GPIO_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_3__GPIO_1_3		IOMUX_PAD(0x7D8, 0x3D0, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_3__I2C2_SDA		IOMUX_PAD(0x7D8, 0x3D0, (2 | IOMUX_CONFIG_SION), \
>  							0x9bc,   3, MX51_I2C_PAD_CTRL)
>  #define MX51_PAD_PMIC_INT_REQ__PMIC_INT_REQ	IOMUX_PAD(0x7FC, 0x3D4, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_GPIO_1_4__GPIO_1_4		IOMUX_PAD(0x804, 0x3D8, 1, 0x0,   0, MX51_GPIO_PAD_CTRL)
> -#define MX51_PAD_GPIO_1_5__GPIO_1_5		IOMUX_PAD(0x808, 0x3DC, 1, 0x0,   0, MX51_GPIO_PAD_CTRL)
> -#define MX51_PAD_GPIO_1_6__GPIO_1_6		IOMUX_PAD(0x80C, 0x3E0, 1, 0x0,   0, MX51_GPIO_PAD_CTRL)
> -#define MX51_PAD_GPIO_1_7__GPIO_1_7		IOMUX_PAD(0x810, 0x3E4, 1, 0x0,   0, MX51_GPIO_PAD_CTRL)
> -#define MX51_PAD_GPIO_1_8__GPIO_1_8		IOMUX_PAD(0x814, 0x3E8, 1, 0x0,   0, MX51_GPIO_PAD_CTRL)
> -#define MX51_PAD_GPIO_1_9__GPIO_1_9		IOMUX_PAD(0x818, 0x3EC, 1, 0x0,   0, MX51_GPIO_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_4__GPIO_1_4		IOMUX_PAD(0x804, 0x3D8, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_5__GPIO_1_5		IOMUX_PAD(0x808, 0x3DC, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_6__GPIO_1_6		IOMUX_PAD(0x80C, 0x3E0, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_7__GPIO_1_7		IOMUX_PAD(0x810, 0x3E4, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_7__ESDHC2_WP		IOMUX_PAD(0x810, 0x3E4, 6, 0x0,   0, MX51_I2C_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_8__GPIO_1_8		IOMUX_PAD(0x814, 0x3E8, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_8__ESDHC2_CD		IOMUX_PAD(0x814, 0x3E8, 6, 0x0,   0, MX51_I2C_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_9__GPIO_1_9		IOMUX_PAD(0x818, 0x3EC, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
Maybe make this in two patches?  One fix and one to add new definitions?

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
