From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 04 Mar 2011 14:50:23 +0300
Subject: staging: iio: ak8975: make gpio platdata mandatory
In-Reply-To: <AANLkTik1MSkfyb36AHUOG+OK=h=rt1D4sbpyUiYg07dT@mail.gmail.com>
References: <AANLkTik1MSkfyb36AHUOG+OK=h=rt1D4sbpyUiYg07dT@mail.gmail.com>
Message-ID: <4D70D1FF.8090302@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04-03-2011 8:34, Naveen Krishna Ch wrote:

> Issue:
> For some architectures CONFIG_GENERIC_GPIO is defined,
> leaving irq_to_gpio undefined.  Causing build break.

> Solution:
> 1. Some architechtures define irq_to_gpio in machine specific code.
> 2. Make GPIO in platdata mandatory.

> Signed-off-by: Naveen Krishna Ch<ch.naveen@samsung.com>
[...]

> diff --git a/drivers/staging/iio/magnetometer/ak8975.c
> b/drivers/staging/iio/magnetometer/ak8975.c
> index 80c0f41..8456d1f 100644
> --- a/drivers/staging/iio/magnetometer/ak8975.c
> +++ b/drivers/staging/iio/magnetometer/ak8975.c
> @@ -98,7 +98,6 @@ struct ak8975_data {
>          unsigned long           mode;
>          u8                      reg_cache[AK8975_MAX_REGS];
>          int                     eoc_gpio;
> -       int                     eoc_irq;

    Your patch seems to be whitespace damaged, i.e. all tabs replaced by spaces.

>   };
>
>   /*
> @@ -453,12 +452,13 @@ static int ak8975_probe(struct i2c_client *client,
>          mutex_init(&data->lock);
>
>          /* Grab and set up the supplied GPIO. */
> -       data->eoc_irq = client->irq;
>          pdata = client->dev.platform_data;
>          if (pdata)
>                  data->eoc_gpio = pdata->gpio;
> -       else
> -               data->eoc_gpio = irq_to_gpio(client->irq);
> +       else {
> +       else {

    Have you tried to compile this?

WBR, Sergei
