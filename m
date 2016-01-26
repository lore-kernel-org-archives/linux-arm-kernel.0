From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 26 Jan 2016 17:31:50 +0800
Subject: [PATCH V3 09/11] soc: mediatek: PMIC wrap: add a slave specific
 struct
In-Reply-To: <1453715604-36856-10-git-send-email-blogic@openwrt.org>
References: <1453715604-36856-1-git-send-email-blogic@openwrt.org>
 <1453715604-36856-10-git-send-email-blogic@openwrt.org>
Message-ID: <1453800710.10901.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi John,

Thanks for preparing the patch.



On Mon, 2016-01-25 at 10:53 +0100, John Crispin wrote:
> This patch adds a new struct pwrap_slv_type that we use to store the slave
> specific data. The patch adds 2 new helper functions to access the dew
> registers. The slave type is looked up via the wrappers child node.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c |  170 +++++++++++++++++++++++++---------
>  1 file changed, 124 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 54553b4..21d8e5a 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
<...>

> +/* defines for slave device wrapper registers */
> +enum dew_regs {
> +	PWRAP_DEW_BASE,
> +	PWRAP_DEW_EVENT_OUT_EN,
> +	PWRAP_DEW_DIO_EN,
> +	PWRAP_DEW_EVENT_SRC_EN,
> +	PWRAP_DEW_EVENT_SRC,
> +	PWRAP_DEW_EVENT_FLAG,
> +	PWRAP_DEW_READ_TEST,
> +	PWRAP_DEW_WRITE_TEST,
> +	PWRAP_DEW_CRC_EN,
> +	PWRAP_DEW_CRC_VAL,
> +	PWRAP_DEW_MON_GRP_SEL,
> +	PWRAP_DEW_MON_FLAG_SEL,
> +	PWRAP_DEW_EVENT_TEST,
> +	PWRAP_DEW_CIPHER_KEY_SEL,
> +	PWRAP_DEW_CIPHER_IV_SEL,
> +	PWRAP_DEW_CIPHER_LOAD,
> +	PWRAP_DEW_CIPHER_START,
> +	PWRAP_DEW_CIPHER_RDY,
> +	PWRAP_DEW_CIPHER_MODE,
> +	PWRAP_DEW_CIPHER_SWRST,
> +	PWRAP_MT8173_DEW_CIPHER_IV0,
> +	PWRAP_MT8173_DEW_CIPHER_IV1,
> +	PWRAP_MT8173_DEW_CIPHER_IV2,
> +	PWRAP_MT8173_DEW_CIPHER_IV3,
> +	PWRAP_MT8173_DEW_CIPHER_IV4,
> +	PWRAP_MT8173_DEW_CIPHER_IV5,


For PWRAP_MT8173_DEW_*, since they exist on pmic mt6397, it seems
strange to name them with MT8173 name. I guess we got this name because
MTK internal code base try to support them in MT8173.

On the other hand, these are not used in current code, maybe we can just
remove them?

Joe.C
