From: chen.zhong@mediatek.com (chen.zhong)
Date: Wed, 28 Jun 2017 20:10:06 +0800
Subject: [PATCH] soc: mtk-pmic-wrap: make of_device_ids const.
In-Reply-To: <ec7445881f9cbd7d7e6a29126dce6e62f9e6b3f1.1498625812.git.arvind.yadav.cs@gmail.com>
References: <ec7445881f9cbd7d7e6a29126dce6e62f9e6b3f1.1498625812.git.arvind.yadav.cs@gmail.com>
Message-ID: <1498651806.6668.2.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Wed, 2017-06-28 at 10:28 +0530, Arvind Yadav wrote:
> of_device_ids are not supposed to change at runtime. All functions
> working with of_device_ids provided by <linux/of.h> work with const
> of_device_ids. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index a5f1093..1205a671 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -1067,7 +1067,7 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
>  	.init_soc_specific = pwrap_mt2701_init_soc_specific,
>  };
>  
> -static struct pmic_wrapper_type pwrap_mt8135 = {
> +static const struct pmic_wrapper_type pwrap_mt8135 = {
>  	.regs = mt8135_regs,
>  	.type = PWRAP_MT8135,
>  	.arb_en_all = 0x1ff,
> @@ -1079,7 +1079,7 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
>  	.init_soc_specific = pwrap_mt8135_init_soc_specific,
>  };
>  
> -static struct pmic_wrapper_type pwrap_mt8173 = {
> +static const struct pmic_wrapper_type pwrap_mt8173 = {
>  	.regs = mt8173_regs,
>  	.type = PWRAP_MT8173,
>  	.arb_en_all = 0x3f,
> @@ -1091,7 +1091,7 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
>  	.init_soc_specific = pwrap_mt8173_init_soc_specific,
>  };
>  
> -static struct of_device_id of_pwrap_match_tbl[] = {
> +static const struct of_device_id of_pwrap_match_tbl[] = {
>  	{
>  		.compatible = "mediatek,mt2701-pwrap",
>  		.data = &pwrap_mt2701,

Acked-by: Chen Zhong <chen.zhong@mediatek.com>
