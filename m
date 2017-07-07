From: mark.yao@rock-chips.com (Mark yao)
Date: Fri, 7 Jul 2017 08:56:28 +0800
Subject: [PATCH] drm/rockchip: fix NULL check on devm_kzalloc() return
 value
In-Reply-To: <20170706215833.GA25411@embeddedgus>
References: <20170706215833.GA25411@embeddedgus>
Message-ID: <595EDC3C.1010801@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?07?07? 05:58, Gustavo A. R. Silva wrote:
> The right variable to check here is port, not dp.
>
> This issue was detected using Coccinelle and the following semantic patch:
>
> @@
> expression x;
> identifier fld;
> @@
>
> * x = devm_kzalloc(...);
>    ... when != x == NULL
>    x->fld
>
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Thanks for the fix,

Acked-by: Mark Yao <mark.yao@rock-chips.com>

> ---
>   drivers/gpu/drm/rockchip/cdn-dp-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> index 14fa1f8..9b0b058 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> @@ -1195,7 +1195,7 @@ static int cdn_dp_probe(struct platform_device *pdev)
>   			continue;
>   
>   		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> -		if (!dp)
> +		if (!port)
>   			return -ENOMEM;
>   
>   		port->extcon = extcon;


-- 
?ark Yao
