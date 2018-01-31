From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 31 Jan 2018 20:22:16 -0200
Subject: [PATCH v3 1/2] ARM: dts: imx25-pinfunc: Use consistent naming for
 eSDHC
In-Reply-To: <20180131213544.4508-1-benoit.thebaudeau.dev@gmail.com>
References: <20180131213544.4508-1-benoit.thebaudeau.dev@gmail.com>
Message-ID: <CAOMZO5C_cV+w_xQg4F2=RqeMEOW8hANB_Td-memf08mPLvtr8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 7:35 PM, Beno?t Th?baudeau
<benoit.thebaudeau.dev@gmail.com> wrote:
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

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
