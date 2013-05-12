From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 12 May 2013 20:40:21 +0530
Subject: [RFC 19/42] drivers/pinctrl/spear: don't check resource with
 devm_ioremap_resource
In-Reply-To: <1368173847-5661-20-git-send-email-wsa@the-dreams.de>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
 <1368173847-5661-20-git-send-email-wsa@the-dreams.de>
Message-ID: <CAOh2x=koaTpBCKqXUtzzx6HbENfTT=mhZvr03LT_QYbiGKgrmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 10, 2013 at 1:47 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/pinctrl/spear/pinctrl-plgpio.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/pinctrl/spear/pinctrl-plgpio.c b/drivers/pinctrl/spear/pinctrl-plgpio.c
> index 3e5a887..6b090be 100644
> --- a/drivers/pinctrl/spear/pinctrl-plgpio.c
> +++ b/drivers/pinctrl/spear/pinctrl-plgpio.c
> @@ -528,18 +528,13 @@ static int plgpio_probe(struct platform_device *pdev)
>         struct resource *res;
>         int ret, irq, i;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res) {
> -               dev_err(&pdev->dev, "invalid IORESOURCE_MEM\n");
> -               return -EBUSY;
> -       }
> -
>         plgpio = devm_kzalloc(&pdev->dev, sizeof(*plgpio), GFP_KERNEL);
>         if (!plgpio) {
>                 dev_err(&pdev->dev, "memory allocation fail\n");
>                 return -ENOMEM;
>         }
>
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         plgpio->base = devm_ioremap_resource(&pdev->dev, res);
>         if (IS_ERR(plgpio->base))
>                 return PTR_ERR(plgpio->base);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
