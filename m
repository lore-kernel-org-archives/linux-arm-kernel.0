From: patrice.chotard@st.com (Patrice Chotard)
Date: Mon, 12 Sep 2016 09:27:14 +0200
Subject: [PATCH -next] hwrng: st - Fix missing clk_disable_unprepare() on
 error in st_rng_probe()
In-Reply-To: <1473509022-3478-1-git-send-email-weiyj.lk@gmail.com>
References: <1473509022-3478-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <f427e4a6-1807-2f32-4a1b-ad3150a17135@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wey

On 09/10/2016 02:03 PM, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix the missing clk_disable_unprepare() before return
> from st_rng_probe() in the error handling case.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/char/hw_random/st-rng.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/hw_random/st-rng.c b/drivers/char/hw_random/st-rng.c
> index 7e8aa6b..938ec10 100644
> --- a/drivers/char/hw_random/st-rng.c
> +++ b/drivers/char/hw_random/st-rng.c
> @@ -108,6 +108,7 @@ static int st_rng_probe(struct platform_device *pdev)
>  	ret = hwrng_register(&ddata->ops);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to register HW RNG\n");
> +		clk_disable_unprepare(clk);
>  		return ret;
>  	}
>  
> 
> 
> 


Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
