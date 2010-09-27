From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Mon, 27 Sep 2010 16:16:51 +0200
Subject: [PATCH 33/40] ARM: mx5/iomux-mx51: Fix input path of some pins in
	gpio mode
In-Reply-To: <1285595476-10025-33-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
	<1285595476-10025-33-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <19616.42835.922236.123809@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> index 9250273..639d631 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> @@ -274,15 +274,15 @@ typedef enum iomux_config {
>  #define MX51_PAD_USBH1_DATA5__USBH1_DATA5       IOMUX_PAD(0x69C, 0x29C, 0, 0x0,   0, MX51_USBH1_PAD_CTRL)
>  #define MX51_PAD_USBH1_DATA6__USBH1_DATA6       IOMUX_PAD(0x6A0, 0x2A0, 0, 0x0,   0, MX51_USBH1_PAD_CTRL)
>  #define MX51_PAD_USBH1_DATA7__USBH1_DATA7       IOMUX_PAD(0x6A4, 0x2A4, 0, 0x0,   0, MX51_USBH1_PAD_CTRL)
> -#define MX51_PAD_DI1_PIN11__GPIO_3_0            IOMUX_PAD(0x6A8, 0x2A8, 4, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_DI1_PIN12__GPIO_3_1            IOMUX_PAD(0x6AC, 0x2AC, 4, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_DI1_PIN13__GPIO_3_2            IOMUX_PAD(0x6B0, 0x2B0, 4, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_DI1_D0_CS__GPIO_3_3            IOMUX_PAD(0x6B4, 0x2B4, 4, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_DI1_D1_CS__GPIO_3_4            IOMUX_PAD(0x6B8, 0x2B8, 4, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_DISPB2_SER_DIN__GPIO_3_5       IOMUX_PAD(0x6BC, 0x2BC, 4, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_DISPB2_SER_DIO__GPIO_3_6       IOMUX_PAD(0x6C0, 0x2C0, 4, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_DISPB2_SER_CLK__GPIO_3_7       IOMUX_PAD(0x6C4, 0x2C4, 4, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_DISPB2_SER_RS__GPIO_3_8        IOMUX_PAD(0x6C8, 0x2C8, 4, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_DI1_PIN11__GPIO_3_0            IOMUX_PAD(0x6A8, 0x2A8, 4, 0x974, 1, NO_PAD_CTRL)
                                                                              ^^^^^
Where did you get this from?
According to my copy of the i.MX51 Reference Manual (MCIMX51RM Rev. 0 11/2009)
the register at 0x974 is IOMUXC_FEC_FEC_TX_CLK_SELECT_INPUT which
controls the pads:
|0: Selecting BGA contact: NANDF_RDY_INT for Mode: ALT1.
|1: Selecting BGA contact: DISP2_DAT13 for Mode: ALT2.
but not DI1_PIN11. DI1_PIN11 does not have any input mux.

The other values seem to be ok.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
