From: patrice.chotard@st.com (Patrice Chotard)
Date: Wed, 2 Nov 2016 14:07:09 +0100
Subject: [PATCH -next] [media] c8sectpfe: fix error return code in
 c8sectpfe_probe()
In-Reply-To: <1477792390-24533-1-git-send-email-weiyj.lk@gmail.com>
References: <1477792390-24533-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <331417b4-9924-6bd4-8c13-ad6ff9fba19f@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/30/2016 02:53 AM, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix to return error code -ENODEV from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
> index 42b123f..69d9a16 100644
> --- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
> +++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
> @@ -813,6 +813,7 @@ static int c8sectpfe_probe(struct platform_device *pdev)
>  		i2c_bus = of_parse_phandle(child, "i2c-bus", 0);
>  		if (!i2c_bus) {
>  			dev_err(&pdev->dev, "No i2c-bus found\n");
> +			ret = -ENODEV;
>  			goto err_clk_disable;
>  		}
>  		tsin->i2c_adapter =
> @@ -820,6 +821,7 @@ static int c8sectpfe_probe(struct platform_device *pdev)
>  		if (!tsin->i2c_adapter) {
>  			dev_err(&pdev->dev, "No i2c adapter found\n");
>  			of_node_put(i2c_bus);
> +			ret = -ENODEV;
>  			goto err_clk_disable;
>  		}
>  		of_node_put(i2c_bus);
> 

Hi Wei

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
