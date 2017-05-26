From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 26 May 2017 14:13:33 +0200
Subject: [PATCH 4/6] regulator: hi6421v530: add driver for hi6421v530
 voltage regulator
In-Reply-To: <20170526063518.21246-5-guodong.xu@linaro.org>
References: <20170526063518.21246-1-guodong.xu@linaro.org>
 <20170526063518.21246-5-guodong.xu@linaro.org>
Message-ID: <CABxcv=kP7XLDhUifwDBEfnayfgjGJFf7v9kUkPS6pcLKiaLP-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Guodong,

On Fri, May 26, 2017 at 8:35 AM, Guodong Xu <guodong.xu@linaro.org> wrote:
> From: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
>

[snip]

>
> +config REGULATOR_HI6421V530
> +       tristate "HiSilicon Hi6421v530 PMIC voltage regulator support"

The Kconfig symbol is tristate so the driver can be built as a module...

> +
> +static struct platform_driver hi6421v530_regulator_driver = {
> +       .driver = {
> +               .name   = "hi6421v530-regulator",
> +       },
> +       .probe  = hi6421v530_regulator_probe,
> +};
> +module_platform_driver(hi6421v530_regulator_driver);

... but the driver doesn't have a platform device ID table nor export
it as a module alias using MODULE_DEVICE_TABLE().

That means that if built as a module, it won't be autoloaded when the
"hi6421v530-regulator" device is registered by the MFD driver.

> +
> +MODULE_AUTHOR("Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>");
> +MODULE_DESCRIPTION("Hi6421v530 regulator driver");
> +MODULE_LICENSE("GPL v2");

Alternative you can add a MODULE_ALIAS().

Best regards,
Javier
