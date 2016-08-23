From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 Aug 2016 09:58:14 +0200
Subject: [PATCH -next] clk: meson: Fix invalid use of sizeof in
 gxbb_aoclkc_probe()
In-Reply-To: <1471882101-22347-1-git-send-email-weiyj.lk@gmail.com>
References: <1471882101-22347-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <f0eeb1b0-5572-506d-0029-30b676c15a57@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2016 06:08 PM, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> sizeof() when applied to a pointer typed expression gives the
> size of the pointer, not that of the pointed data.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/clk/meson/gxbb-aoclk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
> index 61ef28a..b45c5fb 100644
> --- a/drivers/clk/meson/gxbb-aoclk.c
> +++ b/drivers/clk/meson/gxbb-aoclk.c
> @@ -142,7 +142,7 @@ static int gxbb_aoclkc_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct gxbb_aoclk_reset_controller *rstc;
>  
> -	rstc = devm_kzalloc(dev, sizeof(rstc), GFP_KERNEL);
> +	rstc = devm_kzalloc(dev, sizeof(*rstc), GFP_KERNEL);
>  	if (!rstc)
>  		return -ENOMEM;
>  
> 
> 
> 

Aww, my bad.

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Also :
Fixes: f8c11f79912d ("clk: meson: Add GXBB AO Clock and Reset controller driver")
