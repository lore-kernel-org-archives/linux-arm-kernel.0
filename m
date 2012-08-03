From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 3 Aug 2012 16:26:52 +0200
Subject: [PATCH] arm imx31: add a few pinmux settings the tt01 needs
In-Reply-To: <1342616305-24722-1-git-send-email-torbenh@linutronix.de>
References: <1342616305-24722-1-git-send-email-torbenh@linutronix.de>
Message-ID: <20120803142652.GY1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2012 at 02:58:25PM +0200, Torben Hohn wrote:
> These are the Pinmux Settings for the PP4 SSI Port multiplexible
> onto the first UART Pins.
> 
> Signed-off-by: Torben Hohn <torbenh@linutronix.de>

Applied, thanks

Sascha

> ---
>  arch/arm/plat-mxc/include/mach/iomux-mx3.h |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx3.h b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
> index 63f22a0..019b0a0 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx3.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
> @@ -515,12 +515,16 @@ enum iomux_pins {
>  #define MX31_PIN_CSPI3_SPI_RDY__CTS3	IOMUX_MODE(MX31_PIN_CSPI3_SPI_RDY, IOMUX_CONFIG_ALT1)
>  #define MX31_PIN_CTS1__CTS1		IOMUX_MODE(MX31_PIN_CTS1, IOMUX_CONFIG_FUNC)
>  #define MX31_PIN_RTS1__RTS1		IOMUX_MODE(MX31_PIN_RTS1, IOMUX_CONFIG_FUNC)
> +#define MX31_PIN_RTS1__SFS		IOMUX_MODE(MX31_PIN_RTS1, IOMUX_CONFIG_ALT2)
>  #define MX31_PIN_TXD1__TXD1		IOMUX_MODE(MX31_PIN_TXD1, IOMUX_CONFIG_FUNC)
> +#define MX31_PIN_TXD1__SCK		IOMUX_MODE(MX31_PIN_TXD1, IOMUX_CONFIG_ALT2)
>  #define MX31_PIN_RXD1__RXD1		IOMUX_MODE(MX31_PIN_RXD1, IOMUX_CONFIG_FUNC)
> +#define MX31_PIN_RXD1__STXDA		IOMUX_MODE(MX31_PIN_RXD1, IOMUX_CONFIG_ALT2)
>  #define MX31_PIN_DCD_DCE1__DCD_DCE1	IOMUX_MODE(MX31_PIN_DCD_DCE1, IOMUX_CONFIG_FUNC)
>  #define MX31_PIN_RI_DCE1__RI_DCE1	IOMUX_MODE(MX31_PIN_RI_DCE1, IOMUX_CONFIG_FUNC)
>  #define MX31_PIN_DSR_DCE1__DSR_DCE1	IOMUX_MODE(MX31_PIN_DSR_DCE1, IOMUX_CONFIG_FUNC)
>  #define MX31_PIN_DTR_DCE1__DTR_DCE1	IOMUX_MODE(MX31_PIN_DTR_DCE1, IOMUX_CONFIG_FUNC)
> +#define MX31_PIN_DTR_DCE1__SRXDA	IOMUX_MODE(MX31_PIN_DTR_DCE1, IOMUX_CONFIG_ALT2)
>  #define MX31_PIN_CTS2__CTS2		IOMUX_MODE(MX31_PIN_CTS2, IOMUX_CONFIG_FUNC)
>  #define MX31_PIN_RTS2__RTS2		IOMUX_MODE(MX31_PIN_RTS2, IOMUX_CONFIG_FUNC)
>  #define MX31_PIN_TXD2__TXD2		IOMUX_MODE(MX31_PIN_TXD2, IOMUX_CONFIG_FUNC)
> @@ -724,6 +728,7 @@ enum iomux_pins {
>  #define MX31_PIN_KEY_ROW2_KEY_ROW2	IOMUX_MODE(MX31_PIN_KEY_ROW2, IOMUX_CONFIG_FUNC)
>  #define MX31_PIN_KEY_ROW3_KEY_ROW3	IOMUX_MODE(MX31_PIN_KEY_ROW3, IOMUX_CONFIG_FUNC)
>  #define MX31_PIN_KEY_ROW4_KEY_ROW4	IOMUX_MODE(MX31_PIN_KEY_ROW4, IOMUX_CONFIG_FUNC)
> +#define MX31_PIN_KEY_ROW4_GPIO		IOMUX_MODE(MX31_PIN_KEY_ROW4, IOMUX_CONFIG_GPIO)
>  #define MX31_PIN_KEY_ROW5_KEY_ROW5	IOMUX_MODE(MX31_PIN_KEY_ROW5, IOMUX_CONFIG_FUNC)
>  #define MX31_PIN_KEY_ROW6_KEY_ROW6	IOMUX_MODE(MX31_PIN_KEY_ROW6, IOMUX_CONFIG_FUNC)
>  #define MX31_PIN_KEY_ROW7_KEY_ROW7	IOMUX_MODE(MX31_PIN_KEY_ROW7, IOMUX_CONFIG_FUNC)
> -- 
> 1.7.10
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
