From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 24 Mar 2015 20:50:46 +0100
Subject: [PATCH 2/2] ARM: dts: imx25-karo-tx25: Fix pincontrol definition
In-Reply-To: <1427206147-19365-2-git-send-email-mpa@pengutronix.de>
References: <1427206147-19365-1-git-send-email-mpa@pengutronix.de>
 <1427206147-19365-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20150324195046.GU5664@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

[Cc += Lothar Wa?mann]

On Tue, Mar 24, 2015 at 03:09:07PM +0100, Markus Pargmann wrote:
> The iomux group nodes have to be in a pinmux category as described in
> the devicetree binding documentation example. The current definitions
> are not parsed by imx25-pinctrl.
I remember having noticed that problem, too, some time ago, but forgot
to fix/report it.

> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx25-karo-tx25.dts | 84 +++++++++++++++++++----------------
>  1 file changed, 45 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx25-karo-tx25.dts b/arch/arm/boot/dts/imx25-karo-tx25.dts
> index 9b31faa96377..11344fb27727 100644
> --- a/arch/arm/boot/dts/imx25-karo-tx25.dts
> +++ b/arch/arm/boot/dts/imx25-karo-tx25.dts
> @@ -42,49 +42,55 @@
>  };
>  
>  &iomuxc {
> -	pinctrl_uart1: uart1grp {
> -		fsl,pins = <
> -			MX25_PAD_UART1_TXD__UART1_TXD 0x80000000
> -			MX25_PAD_UART1_RXD__UART1_RXD 0x80000000
> -			MX25_PAD_UART1_CTS__UART1_CTS 0x80000000
> -			MX25_PAD_UART1_RTS__UART1_RTS 0x80000000
> -		>;
> +	uart1 {
Some other machines (e.g. imx51-babbage) use a big group named after the
machine for all pin groups. Would it be nice to have a uniform rule
here?

I think this grouping is a relict from the time when we considered to
list the groups in the imx$num.dtsi? I would prefer to "fix" the driver
to work with the way imx25-karo-tx25 presents the pinmuxing because I
don't see the motivation for this extra grouping. (So let us define the
current method of imx25-karo-tx25 as the good one to follow if you ask
me.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
