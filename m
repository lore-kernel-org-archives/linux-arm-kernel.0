From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Fri, 8 Oct 2010 11:54:56 +0200
Subject: [PATCH] ARM: iomux-mx51: Add AUD5 pinmux definitions
In-Reply-To: <1286530791-23105-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1286530791-23105-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <19630.60016.791128.856262@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig writes:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/plat-mxc/include/mach/iomux-mx51.h |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> index 633650d..0d89854 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> @@ -334,11 +334,17 @@ typedef enum iomux_config {
>  #define MX51_PAD_DISP2_DAT14__DISP2_DAT14       IOMUX_PAD(0x794, 0x38C, 0, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_DISP2_DAT15__DISP2_DAT15       IOMUX_PAD(0x798, 0x390, 0, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_SD1_CMD__SD1_CMD               IOMUX_PAD(0x79C, 0x394, 0, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_SD1_CMD__AUD5_RXFS             IOMUX_PAD(0x79C, 0x394, 1, 0x8e0, 1, NO_PAD_CTRL)
>  #define MX51_PAD_SD1_CLK__SD1_CLK               IOMUX_PAD(0x7A0, 0x398, 0, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_SD1_CLK__AUD5_RXC              IOMUX_PAD(0x7A0, 0x398, 1, 0x8dc, 1, NO_PAD_CTRL)
>  #define MX51_PAD_SD1_DATA0__SD1_DATA0           IOMUX_PAD(0x7A4, 0x39C, 0, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_SD1_DATA0__AUD5_TXD            IOMUX_PAD(0x7A4, 0x39C, 1, 0x8d8, 1, NO_PAD_CTRL)
                                                                                     ^
The input mux setting should be '2' here:
| Instance: audmux, In Pin: p5_input_db_amx
|00: Selecting Pad: EIM_D16 for Mode: ALT7.
|01: Selecting Pad: EIM_CS2 for Mode: ALT6.
|10: Selecting Pad: SD1_DATA0 for Mode: ALT1.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
