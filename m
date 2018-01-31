From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 31 Jan 2018 08:29:31 +0100
Subject: [PATCH v2 2/2] ARM: dts: imx25-pinfunc: Always set SION for
 eSDHC CMD
In-Reply-To: <20180131000514.5286-2-benoit.thebaudeau.dev@gmail.com>
References: <20180131000514.5286-1-benoit.thebaudeau.dev@gmail.com>
 <20180131000514.5286-2-benoit.thebaudeau.dev@gmail.com>
Message-ID: <20180131072931.2hymk6xzerplfhcr@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Beno?t,

On Wed, Jan 31, 2018 at 01:05:14AM +0100, Beno?t Th?baudeau wrote:
> The eSDHC does not work properly if the SION bit is not set for the
> bidirectional CMD signal, whatever the eSDHC instance and the selected
> pad. Therefore, setting SION is mandatory for all eSDHC CMD ports. Do
> this for MX25_PAD_*__ESDHCn_CMD in imx25-pinfunc.h in order to enforce
> this behavior for all boards.
> 
> This had already been done for eSDHC1, but not for eSDHC2. Also, define
> MX25_PAD_FEC_MDC__ESDHC2_CMD so that all the possible cases are covered
> from now on.
> 
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau.dev@gmail.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Changes v1 -> v2:
>  - Update eSDHC instance and port naming following the addition of "ARM:
>    dts: imx25-pinfunc: Use consistent naming for eSDHC".
>  - Reference the more verbose comment for MX25_PAD_SD1_CMD__ESDHC1_CMD
>    instead of copying the same less detailed comment everywhere
>    (suggested by Uwe).
> ---
>  arch/arm/boot/dts/imx25-pinfunc.h | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx25-pinfunc.h b/arch/arm/boot/dts/imx25-pinfunc.h
> index 2915c65a13c9..71a61c4c984f 100644
> --- a/arch/arm/boot/dts/imx25-pinfunc.h
> +++ b/arch/arm/boot/dts/imx25-pinfunc.h
> @@ -236,7 +236,8 @@
>  #define MX25_PAD_LD8__LD8			0x0e8 0x2e0 0x000 0x00 0x000
>  #define MX25_PAD_LD8__UART4_RXD			0x0e8 0x2e0 0x570 0x02 0x000
>  #define MX25_PAD_LD8__FEC_TX_ERR		0x0e8 0x2e0 0x000 0x05 0x000
> -#define MX25_PAD_LD8__ESDHC2_CMD		0x0e8 0x2e0 0x4e0 0x06 0x000
> +/* See the comment for MX25_PAD_SD1_CMD__ESDHC1_CMD. */

I'd write:

	/* SION must be set, see the comment for MX25_PAD_SD1_CMD__ESDHC1_CMD. */

to at least mention SION here.

Other than that the commit looks fine.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
