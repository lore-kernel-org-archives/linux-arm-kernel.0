From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Aug 2010 08:29:56 +0200
Subject: [PATCH] mx51_babbage: Add FEC support
In-Reply-To: <620138.80679.qm@web51004.mail.re2.yahoo.com>
References: <620138.80679.qm@web51004.mail.re2.yahoo.com>
Message-ID: <20100819062956.GB27749@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Wed, Aug 18, 2010 at 05:54:36PM -0700, Fabio Estevam wrote:
  /*
>   * The naming convention for the pad modes is MX51_PAD_<padname>__<padmode>
>   * If <padname> or <padmode> refers to a GPIO, it is named GPIO_<unit>_<num>
> @@ -322,4 +329,22 @@ typedef enum iomux_config {
>  #define MX51_PAD_GPIO_1_8__GPIO_1_8		IOMUX_PAD(0x814, 0x3E8, 0, 0x0,   1, MX51_GPIO_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_9__GPIO_1_9		IOMUX_PAD(0x818, 0x3EC, 0, 0x0,   0, NO_PAD_CTRL)
>  
> +#define MX51_PAD_EIM_EB2__FEC_MDIO		IOMUX_PAD(0x468, 0x0d4, 3, 0x0,   0, MX51_PAD_CTRL_1 | PAD_CTL_PUS_22K_UP)
> +#define MX51_PAD_EIM_EB3__FEC_RDAT1		IOMUX_PAD(0x46c, 0x0d8, 3, 0x0,   0, MX51_PAD_CTRL_2)
> +#define MX51_PAD_EIM_CS2__FEC_RDAT2		IOMUX_PAD(0x47c, 0x0e8, 3, 0x0,   0, MX51_PAD_CTRL_2)
> +#define MX51_PAD_EIM_CS3__FEC_RDAT3		IOMUX_PAD(0x480, 0x0ec, 3, 0x0,   0, MX51_PAD_CTRL_2)
> +#define MX51_PAD_EIM_CS4__FEC_RX_ER		IOMUX_PAD(0x484, 0x0f0, 3, 0x0,   0, MX51_PAD_CTRL_2)
> +#define MX51_PAD_EIM_CS5__FEC_CRS		IOMUX_PAD(0x488, 0x0f4, 3, 0x0,   0, MX51_PAD_CTRL_2)
> +#define MX51_PAD_NANDF_RB2__FEC_COL		IOMUX_PAD(0x500, 0x124, 1, 0x0, 0, MX51_PAD_CTRL_2)
> +#define MX51_PAD_NANDF_RB3__FEC_RXCLK		IOMUX_PAD(0x504, 0x128, 1, 0x0, 0, MX51_PAD_CTRL_2)
> +#define MX51_PAD_NANDF_RB7__FEC_TDAT0		IOMUX_PAD(0x5E0, 0x138, 1, 0x0, 0, MX51_PAD_CTRL_5)
> +#define MX51_PAD_NANDF_RB6__FEC_RDAT0		IOMUX_PAD(0x5DC, 0x134, 1, 0x0, 0, MX51_PAD_CTRL_4)
> +#define MX51_PAD_NANDF_CS2__FEC_TX_ER		IOMUX_PAD(0x520, 0x138, 2, 0x0, 0, MX51_PAD_CTRL_5)
> +#define MX51_PAD_NANDF_CS3__FEC_MDC		IOMUX_PAD(0x524, 0x13C, 2, 0x0, 0, MX51_PAD_CTRL_5)
> +#define MX51_PAD_NANDF_CS4__FEC_TDAT1		IOMUX_PAD(0x528, 0x140, 2, 0x0, 0, MX51_PAD_CTRL_5)
> +#define MX51_PAD_NANDF_CS5__FEC_TDAT2		IOMUX_PAD(0x52C, 0x144, 2, 0x0, 0, MX51_PAD_CTRL_5)
> +#define MX51_PAD_NANDF_CS6__FEC_TDAT3		IOMUX_PAD(0x530, 0x148, 2, 0x0, 0, MX51_PAD_CTRL_5)
> +#define MX51_PAD_NANDF_CS7__FEC_TX_EN		IOMUX_PAD(0x534, 0x14C, 1, 0x0, 0, MX51_PAD_CTRL_5)
> +#define MX51_PAD_NANDF_RDY_INT__FEC_TX_CLK	IOMUX_PAD(0x538, 0x150, 1, 0x0, 0, MX51_PAD_CTRL_4)

Please keep this list ordered by pad names, so MX51_PAD_EIM_EB2__FEC_MDIO
should come after MX51_PAD_EIM_EB2__GPIO_2_22.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
