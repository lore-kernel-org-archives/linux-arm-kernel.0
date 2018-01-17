From: fabien.dessenne@st.com (Fabien DESSENNE)
Date: Wed, 17 Jan 2018 13:02:40 +0000
Subject: [PATCH -next] crypto: stm32 - remove redundant dev_err call in
 stm32_cryp_probe()
In-Reply-To: <1516189224-11877-1-git-send-email-weiyongjun1@huawei.com>
References: <1516189224-11877-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <d2641cbb-61fa-00e7-6ac8-f05d3cde0628@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Thank you for the patch.


On 17/01/18 12:40, Wei Yongjun wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>   drivers/crypto/stm32/stm32-cryp.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
> index cf1dddb..4a06a7a 100644
> --- a/drivers/crypto/stm32/stm32-cryp.c
> +++ b/drivers/crypto/stm32/stm32-cryp.c
> @@ -1052,10 +1052,8 @@ static int stm32_cryp_probe(struct platform_device *pdev)
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	cryp->regs = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(cryp->regs)) {
> -		dev_err(dev, "Cannot map CRYP IO\n");
> +	if (IS_ERR(cryp->regs))
>   		return PTR_ERR(cryp->regs);
> -	}
>   
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq < 0) {
>
