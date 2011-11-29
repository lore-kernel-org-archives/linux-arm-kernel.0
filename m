From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 29 Nov 2011 20:33:04 +0100
Subject: [PATCH] ARM: mxs: Select FEC driver
In-Reply-To: <1322592607-22834-1-git-send-email-fabio.estevam@freescale.com>
References: <1322592607-22834-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20111129193304.GP17668@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 04:50:07PM -0200, Fabio Estevam wrote:
> Let the FEC driver be built by default.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/configs/mxs_defconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
> index 6ee781b..f99bcfc 100644
> --- a/arch/arm/configs/mxs_defconfig
> +++ b/arch/arm/configs/mxs_defconfig
> @@ -59,6 +59,8 @@ CONFIG_DEVTMPFS=y
>  # CONFIG_BLK_DEV is not set
>  CONFIG_NETDEVICES=y
>  CONFIG_NET_ETHERNET=y
> +CONFIG_NET_VENDOR_FREESCALE=y
> +CONFIG_FEC=y
I'd prefer to add

	default y

or maybe

	default y if SOME_SENSIBLE_OPTION

to NET_VENDOR_FREESCALE and FEC instead. We already had that, but Shawn
removed it in

	230dec6 (net/fec: add imx6q enet support)

(by mistake if I remember an earlier thread here correctly).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
