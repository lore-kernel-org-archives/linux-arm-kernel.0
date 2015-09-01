From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 1 Sep 2015 11:45:19 +0200
Subject: [PATCH] pinctrl: mediatek: Consistently use the BIT() macro
In-Reply-To: <1440804302-6903-1-git-send-email-javier@osg.samsung.com>
References: <1440804302-6903-1-git-send-email-javier@osg.samsung.com>
Message-ID: <55E573AF.4060408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/08/15 01:25, Javier Martinez Canillas wrote:
> The mediatek pinctrl driver uses the BIT() macro instead of open
> coding 1 << n in all but one place. Replace this occurrence with
> the BIT() macro for consistency.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>
> ---
>
>   drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index 23f2de07f598..497b9125342a 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -898,7 +898,7 @@ static int mtk_eint_flip_edge(struct mtk_pinctrl *pctl, int hwirq)
>   	int start_level, curr_level;
>   	unsigned int reg_offset;
>   	const struct mtk_eint_offsets *eint_offsets = &(pctl->devdata->eint_offsets);
> -	u32 mask = 1 << (hwirq & 0x1f);
> +	u32 mask = BIT(hwirq & 0x1f);
>   	u32 port = (hwirq >> 5) & eint_offsets->port_mask;
>   	void __iomem *reg = pctl->eint_reg_base + (port << 2);
>   	const struct mtk_desc_pin *pin;
>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
