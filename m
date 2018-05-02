From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 2 May 2018 12:29:14 +0200
Subject: [PATCH V4 4/8] soc: mediatek: pwrap: add int1_en_all flag
In-Reply-To: <20180502092112.3991-5-argus.lin@mediatek.com>
References: <20180502092112.3991-1-argus.lin@mediatek.com>
 <20180502092112.3991-5-argus.lin@mediatek.com>
Message-ID: <ca4fcfaa-7be6-8895-9774-1995d8183f13@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/02/2018 11:21 AM, argus.lin at mediatek.com wrote:
> From: Argus Lin <argus.lin@mediatek.com>
> 
> MT6797 support int1_en flag for starvation
> and cmd_miss exception interrupt. We add
> a new flag int1_en_all to check if we need
> to enable interrupt source or not.
> 
> Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
Same as 2/8. We need the logic that uses this flag in the same patch not in a
later one.

> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 911a8508f39f..a6366f147b79 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -687,6 +687,7 @@ struct pmic_wrapper_type {
>  	enum pwrap_type type;
>  	u32 arb_en_all;
>  	u32 int_en_all;
> +	u32 int1_en_all;
>  	u32 spi_w;
>  	u32 wdt_src;
>  	/* Flags indicating the capability for the target pwrap */
> @@ -1398,6 +1399,7 @@ static const struct pmic_wrapper_type pwrap_mt2701 = {
>  	.type = PWRAP_MT2701,
>  	.arb_en_all = 0x3f,
>  	.int_en_all = ~(u32)(BIT(31) | BIT(2)),
> +	.int1_en_all = 0,
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE_NEW,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
>  	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
> @@ -1410,6 +1412,7 @@ static const struct pmic_wrapper_type pwrap_mt7622 = {
>  	.type = PWRAP_MT7622,
>  	.arb_en_all = 0xff,
>  	.int_en_all = ~(u32)BIT(31),
> +	.int1_en_all = 0,
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
>  	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
> @@ -1422,6 +1425,7 @@ static const struct pmic_wrapper_type pwrap_mt8135 = {
>  	.type = PWRAP_MT8135,
>  	.arb_en_all = 0x1ff,
>  	.int_en_all = ~(u32)(BIT(31) | BIT(1)),
> +	.int1_en_all = 0,
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
>  	.caps = PWRAP_CAP_BRIDGE | PWRAP_CAP_RESET | PWRAP_CAP_DCM,
> @@ -1434,6 +1438,7 @@ static const struct pmic_wrapper_type pwrap_mt8173 = {
>  	.type = PWRAP_MT8173,
>  	.arb_en_all = 0x3f,
>  	.int_en_all = ~(u32)(BIT(31) | BIT(1)),
> +	.int1_en_all = 0,
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_NO_STAUPD,
>  	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
> -- 
> 2.12.5
> 
> ************* Email Confidentiality Notice ********************
> The information contained in this e-mail message (including any 
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be 
> conveyed only to the designated recipient(s). Any use, dissemination, 
> distribution, printing, retaining or copying of this e-mail (including its 
> attachments) by unintended recipient(s) is strictly prohibited and may 
> be unlawful. If you are not an intended recipient of this e-mail, or believe 
> that you have received this e-mail in error, please notify the sender 
> immediately (by replying to this e-mail), delete any and all copies of 
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!
> 
