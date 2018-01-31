From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 31 Jan 2018 08:26:44 +0100
Subject: [PATCH v2 1/2] ARM: dts: imx25-pinfunc: Use consistent naming
 for eSDHC
In-Reply-To: <20180131000514.5286-1-benoit.thebaudeau.dev@gmail.com>
References: <20180131000514.5286-1-benoit.thebaudeau.dev@gmail.com>
Message-ID: <20180131072644.nbr6t5rhx7yb4dhj@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jan 31, 2018 at 01:05:13AM +0100, Beno?t Th?baudeau wrote:
> This file had several naming inconsistencies for eSDHC:
>  - the instances were named sometimes SDn, sometimes SDHCn, whereas they
>    are named ESDHCn in the reference manual, e.g.:
>      MX25_PAD_SD1_CMD__SD1_CMD
>      MX25_PAD_D15__SDHC1_DAT7
>  - the data ports were named sometimes DATAn, sometimes DATn like in the
>    reference manual, e.g.:
>      MX25_PAD_SD1_DATA0__SD1_DATA0
>      MX25_PAD_D15__SDHC1_DAT7
>  - in one case, the clock port was named DAT_CLK instead of CLK:
>      MX25_PAD_CSI_D7__SDHC2_DAT_CLK
> 
> This change:
>  - introduces new definitions using the naming from the reference
>    manual,
>  - keeps definitions using the legacy naming in order not to break
>    compatibility for out-of-tree users (they can be removed later),
>  - updates the in-tree files that were using the legacy naming.
> 
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau.dev@gmail.com>
> ---
> Changes v1 -> v2:
>  - New patch (suggested by Uwe).
That's why I like it:

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

:-)
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
