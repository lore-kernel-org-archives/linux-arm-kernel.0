From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Tue, 20 Mar 2018 13:21:48 +0000
Subject: [PATCH -next] phy: stm32: fix using 0 as NULL pointer warnings
In-Reply-To: <1521551982-154471-1-git-send-email-weiyongjun1@huawei.com>
References: <1521551982-154471-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <3d799714-6e2c-658e-b1f2-def58584c356@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/20/2018 02:19 PM, Wei Yongjun wrote:
> Fixes the following sparse warnings:
> 
> drivers/phy/st/phy-stm32-usbphyc.c:331:42: warning:
>   Using plain integer as NULL pointer
> drivers/phy/st/phy-stm32-usbphyc.c:344:52: warning:
>   Using plain integer as NULL pointer
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   drivers/phy/st/phy-stm32-usbphyc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
> index bc4e78a..48d4086 100644
> --- a/drivers/phy/st/phy-stm32-usbphyc.c
> +++ b/drivers/phy/st/phy-stm32-usbphyc.c
> @@ -328,7 +328,7 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
>   	if (IS_ERR(usbphyc->base))
>   		return PTR_ERR(usbphyc->base);
>   
> -	usbphyc->clk = devm_clk_get(dev, 0);
> +	usbphyc->clk = devm_clk_get(dev, NULL);
>   	if (IS_ERR(usbphyc->clk)) {
>   		ret = PTR_ERR(usbphyc->clk);
>   		dev_err(dev, "clk get failed: %d\n", ret);
> @@ -341,7 +341,7 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	usbphyc->rst = devm_reset_control_get(dev, 0);
> +	usbphyc->rst = devm_reset_control_get(dev, NULL);
>   	if (!IS_ERR(usbphyc->rst)) {
>   		reset_control_assert(usbphyc->rst);
>   		udelay(2);
> 

Reviewed-by: Amelie Delaunay <amelie.delaunay@st.com>

Thanks,
Amelie
