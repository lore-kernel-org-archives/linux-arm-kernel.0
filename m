From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Feb 2018 00:08:53 -0600
Subject: [PATCH v3 1/2] ARM: dts: imx25-pinfunc: Use consistent naming
 for eSDHC
In-Reply-To: <20180131213544.4508-1-benoit.thebaudeau.dev@gmail.com>
References: <20180131213544.4508-1-benoit.thebaudeau.dev@gmail.com>
Message-ID: <20180205060853.ebqs3sqakpxm22uk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 10:35:43PM +0100, Beno?t Th?baudeau wrote:
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
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Changes v2 -> v3:
>  - None.
> Changes v1 -> v2:
>  - New patch (suggested by Uwe).
> ---
>  .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  | 12 ++--
>  arch/arm/boot/dts/imx25-pdk.dts                    | 12 ++--
>  arch/arm/boot/dts/imx25-pinfunc.h                  | 72 ++++++++++++++--------
>  3 files changed, 60 insertions(+), 36 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
