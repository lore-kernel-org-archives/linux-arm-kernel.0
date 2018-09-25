From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 25 Sep 2018 16:36:11 +0200
Subject: [PATCH] soc: mediatek: pwrap: use true and false for boolean
 values
In-Reply-To: <20180805010201.GA7320@embeddedor.com>
References: <20180805010201.GA7320@embeddedor.com>
Message-ID: <a28e3cce-99e7-fb6d-e57b-9c41f1296f29@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/08/2018 03:02, Gustavo A. R. Silva wrote:
> Return statements in functions returning bool should use true or false
> instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Applied, thanks!

Matthias

>  drivers/soc/mediatek/mtk-pmic-wrap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 4e931fd..932470a 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -1096,7 +1096,7 @@ static bool pwrap_is_pmic_cipher_ready(struct pmic_wrapper *wrp)
>  	ret = pwrap_read(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_RDY],
>  			 &rdata);
>  	if (ret)
> -		return 0;
> +		return false;
>  
>  	return rdata == 1;
>  }
> 
