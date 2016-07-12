From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 12 Jul 2016 10:06:38 -0700
Subject: [PATCH -next] pinctrl: ns2: remove redundant dev_err call in
 ns2_pinmux_probe()
In-Reply-To: <1468333185-8047-1-git-send-email-weiyj_lk@163.com>
References: <1468333185-8047-1-git-send-email-weiyj_lk@163.com>
Message-ID: <21ef4829-b6b5-6b37-e3b2-ffabcfb0b91d@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

On 7/12/2016 7:19 AM, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/pinctrl/bcm/pinctrl-ns2-mux.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pinctrl/bcm/pinctrl-ns2-mux.c b/drivers/pinctrl/bcm/pinctrl-ns2-mux.c
> index 7e5f7b7..ca81789 100644
> --- a/drivers/pinctrl/bcm/pinctrl-ns2-mux.c
> +++ b/drivers/pinctrl/bcm/pinctrl-ns2-mux.c
> @@ -1044,10 +1044,8 @@ static int ns2_pinmux_probe(struct platform_device *pdev)
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
> @@ -1059,10 +1057,8 @@ static int ns2_pinmux_probe(struct platform_device *pdev)
>
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
>  	pinctrl->pinconf_base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(pinctrl->pinconf_base)) {
> -		dev_err(&pdev->dev, "unable to map I/O space\n");
> +	if (IS_ERR(pinctrl->pinconf_base))
>  		return PTR_ERR(pinctrl->pinconf_base);
> -	}
>
>  	ret = ns2_mux_log_init(pinctrl);
>  	if (ret) {
>
>
>
>

Looks good to me! Thanks.

Acked-by: Ray Jui <ray.jui@broadcom.com>
