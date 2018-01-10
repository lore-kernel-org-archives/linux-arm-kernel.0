From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 10 Jan 2018 10:01:15 +0100
Subject: [PATCH 2/2] pinctrl: mediatek: mt7622: align error handling of
 mtk_hw_get_value call
In-Reply-To: <0eb8fd904f9b49d0e992bc2ee725d057f94cf735.1515514758.git.sean.wang@mediatek.com>
References: <a26c40a8ad2af3cf81b31ae34bc82c1ef80d9279.1515514758.git.sean.wang@mediatek.com>
 <0eb8fd904f9b49d0e992bc2ee725d057f94cf735.1515514758.git.sean.wang@mediatek.com>
Message-ID: <dcb31687-5b5e-13fc-022b-b48f1498617b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/09/2018 05:28 PM, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Make consistent error handling of all mtk_hw_get_value occurrences using
> propagating error code from the internal instead of creating a new one.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> -->  drivers/pinctrl/mediatek/pinctrl-mt7622.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
> index dc32e3c..06e8406 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
> @@ -1160,7 +1160,7 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
>  	case PIN_CONFIG_OUTPUT_ENABLE:
>  		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_DIR, &val);
>  		if (err)
> -			return -EINVAL;
> +			return err;
>  
>  		/* HW takes input mode as zero; output mode as non-zero */
>  		if ((val && param == PIN_CONFIG_INPUT_ENABLE) ||
> @@ -1184,11 +1184,11 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
>  	case PIN_CONFIG_DRIVE_STRENGTH:
>  		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_E4, &val);
>  		if (err)
> -			return -EINVAL;
> +			return err;
>  
>  		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_E8, &val2);
>  		if (err)
> -			return -EINVAL;
> +			return err;
>  
>  		/* 4mA when (e8, e4) = (0, 0); 8mA when (e8, e4) = (0, 1)
>  		 * 12mA when (e8, e4) = (1, 0); 16mA when (e8, e4) = (1, 1)
> @@ -1203,7 +1203,7 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
>  
>  		err = mtk_hw_get_value(hw, pin, reg, &val);
>  		if (err)
> -			return -EINVAL;
> +			return err;
>  
>  		ret = val;
>  
> 
