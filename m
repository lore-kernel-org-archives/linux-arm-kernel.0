From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 6 Jul 2018 15:51:07 +0200
Subject: [PATCH] media: stm32: dcmi: replace "%p" with "%pK"
In-Reply-To: <20180706130355.22100-1-benjamin.gaignard@st.com>
References: <20180706130355.22100-1-benjamin.gaignard@st.com>
Message-ID: <64b2a2ea-2da9-c40d-eae4-6375079771e7@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/18 15:03, Benjamin Gaignard wrote:
> The format specifier "%p" can leak kernel addresses.
> Use "%pK" instead.

This patch no longer applies. AFAICT it is obsolete after some code reorg.

Regards,

	Hans

> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/media/platform/stm32/stm32-dcmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
> index 2e1933d872ee..fe90672cf16f 100644
> --- a/drivers/media/platform/stm32/stm32-dcmi.c
> +++ b/drivers/media/platform/stm32/stm32-dcmi.c
> @@ -1753,7 +1753,7 @@ static int dcmi_probe(struct platform_device *pdev)
>  
>  	ret = clk_prepare(mclk);
>  	if (ret) {
> -		dev_err(&pdev->dev, "Unable to prepare mclk %p\n", mclk);
> +		dev_err(&pdev->dev, "Unable to prepare mclk %pK\n", mclk);
>  		goto err_dma_release;
>  	}
>  
> 
