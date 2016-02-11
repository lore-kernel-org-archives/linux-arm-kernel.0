From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 11 Feb 2016 12:41:51 +0100
Subject: [PATCH V5 11/11] soc: mediatek: PMIC wrap: add MT2701/7623 support
In-Reply-To: <1454841778-35529-12-git-send-email-blogic@openwrt.org>
References: <1454841778-35529-1-git-send-email-blogic@openwrt.org>
 <1454841778-35529-12-git-send-email-blogic@openwrt.org>
Message-ID: <56BC737F.9070503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/02/16 11:42, John Crispin wrote:
> Add the registers, callbacks and data structures required to make the
> wrapper work on MT2701 and MT7623.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c |  162 ++++++++++++++++++++++++++++++++++
>   1 file changed, 162 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 5fbdd5c..ee6d917 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -52,6 +52,7 @@
>   #define PWRAP_DEW_WRITE_TEST_VAL	0xa55a
>
>   /* macro for manual command */
> +#define PWRAP_MAN_CMD_SPI_WRITE_NEW	(1 << 14)
>   #define PWRAP_MAN_CMD_SPI_WRITE		(1 << 13)
>   #define PWRAP_MAN_CMD_OP_CSH		(0x0 << 8)
>   #define PWRAP_MAN_CMD_OP_CSL		(0x1 << 8)
> @@ -202,6 +203,17 @@ enum pwrap_regs {
>   	PWRAP_DCM_EN,
>   	PWRAP_DCM_DBC_PRD,
>
> +	/* MT2701 only regs */
> +	PWRAP_OP_TYPE,
> +	PWRAP_MSB_FIRST,
> +	PWRAP_GPS_STA,
> +	PWRAP_ADC_CMD_ADDR,
> +	PWRAP_PWRAP_ADC_CMD,
> +	PWRAP_ADC_RDY_ADDR,
> +	PWRAP_ADC_RDATA_ADDR1,
> +	PWRAP_ADC_RDATA_ADDR2,
> +	PWRAP_ADC_WRAP_SEL,
> +

Same here, we should just declare the registers actually used.

Thanks,
Matthias
