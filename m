From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 11 Oct 2018 11:29:27 +0200
Subject: [PATCH 4/5] pinctrl: mediatek: pinctrl-mtk-common-v2: Make eint_m
 u16
In-Reply-To: <20181008191411.32555-5-manivannan.sadhasivam@linaro.org>
References: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
 <20181008191411.32555-5-manivannan.sadhasivam@linaro.org>
Message-ID: <e2df8c8a-34a1-ef32-838d-776053b1b707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/10/2018 21:14, Manivannan Sadhasivam wrote:
> For SoC's which lacks EINT support, U16_MAX is assigned to both eint_m
> and eint_n through macro NO_EINT_SUPPORT. This will generate integer
> overflow warning because eint_m is declared as u8 type. Hence modify
> the eint_m type to u16.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> index 991c1c56670c..6d24522739d9 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> @@ -154,7 +154,7 @@ struct mtk_func_desc {
>   * @eitn_n:		the eint number for this pin
>   */
>  struct mtk_eint_desc {
> -	u8 eint_m;
> +	u16 eint_m;
>  	u16 eint_n;
>  };
>  
> 
