From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 14 Oct 2013 10:44:46 +0200
Subject: [PATCH 5/5] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type
In-Reply-To: <1381739024-24924-6-git-send-email-shawn.guo@linaro.org>
References: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
 <1381739024-24924-6-git-send-email-shawn.guo@linaro.org>
Message-ID: <20131014104446.60dbf1d7@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Shawn Guo wrote:
> We now have 'flags' in struct pltfm_imx_data to identify the features
> and quirks for ESDHC variants running on different i.MX SoCs.  The enum
> imx_esdhc_type can be eliminated by interpreting the ESDHC variants with
> the ESDHC_FLAG_* flags.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   52 +++++-------------------------------
>  1 file changed, 6 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index f1e1385..f2cd5b0 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -100,18 +100,15 @@
[...]
> +#define IMX35_ESDHC	(ESDHC_FLAG_ENGCM07207)
> +#define IMX51_ESDHC	(0)
> +#define IMX53_ESDHC	(ESDHC_FLAG_MULTIBLK_NO_INT)
> +#define IMX6Q_USDHC	(ESDHC_FLAG_USDHC)
>  
Useless parenthesis.

Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
