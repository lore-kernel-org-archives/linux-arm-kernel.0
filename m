From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 17 Jan 2017 16:20:13 +0100
Subject: [PATCH -next] mtd: nand: mediatek: remove redundant dev_err call
 in mtk_nfc_probe()
In-Reply-To: <20170117142246.9607-1-weiyj.lk@gmail.com>
References: <20170117142246.9607-1-weiyj.lk@gmail.com>
Message-ID: <998d159a-d262-6849-b518-6282ae0e183a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2017 03:22 PM, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Marek Vasut <marek.vasut@gmail.com>

> ---
>  drivers/mtd/nand/mtk_nand.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/mtk_nand.c b/drivers/mtd/nand/mtk_nand.c
> index 6c3eed3..6c517c6 100644
> --- a/drivers/mtd/nand/mtk_nand.c
> +++ b/drivers/mtd/nand/mtk_nand.c
> @@ -1383,7 +1383,6 @@ static int mtk_nfc_probe(struct platform_device *pdev)
>  	nfc->regs = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(nfc->regs)) {
>  		ret = PTR_ERR(nfc->regs);
> -		dev_err(dev, "no nfi base\n");
>  		goto release_ecc;
>  	}
>  
> 
> 
> 


-- 
Best regards,
Marek Vasut
