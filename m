From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 6 Jul 2016 09:21:16 -0700
Subject: [PATCH -next] pinctrl: nsp: remove redundant dev_err call in
 nsp_pinmux_probe()
In-Reply-To: <1467806571-23811-1-git-send-email-weiyj_lk@163.com>
References: <1467806571-23811-1-git-send-email-weiyj_lk@163.com>
Message-ID: <b3e5211a-9f34-0909-691c-25369928731e@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

On 7/6/2016 5:02 AM, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/pinctrl/bcm/pinctrl-nsp-mux.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pinctrl/bcm/pinctrl-nsp-mux.c b/drivers/pinctrl/bcm/pinctrl-nsp-mux.c
> index 7df0880b..4149db3 100644
> --- a/drivers/pinctrl/bcm/pinctrl-nsp-mux.c
> +++ b/drivers/pinctrl/bcm/pinctrl-nsp-mux.c
> @@ -573,10 +573,8 @@ static int nsp_pinmux_probe(struct platform_device *pdev)
>
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	pinctrl->base0 = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(pinctrl->base0)) {
> -		dev_err(&pdev->dev, "unable to map I/O space\n");
> +	if (IS_ERR(pinctrl->base0))
>  		return PTR_ERR(pinctrl->base0);
> -	}
>
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  	pinctrl->base1 = devm_ioremap_nocache(&pdev->dev, res->start,
> @@ -588,10 +586,8 @@ static int nsp_pinmux_probe(struct platform_device *pdev)
>
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
>  	pinctrl->base2 = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(pinctrl->base2)) {
> -		dev_err(&pdev->dev, "unable to map I/O space\n");
> +	if (IS_ERR(pinctrl->base2))
>  		return PTR_ERR(pinctrl->base2);
> -	}
>
>  	ret = nsp_mux_log_init(pinctrl);
>  	if (ret) {
>
>
>
>

Looks good to me. Thanks!

Acked-by: Ray Jui <ray.jui@broadcom.com>
