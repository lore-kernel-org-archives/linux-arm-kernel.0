From: guodong.xu@linaro.org (Guodong Xu)
Date: Sat, 27 May 2017 17:42:01 +0800
Subject: [PATCH 4/6] regulator: hi6421v530: add driver for hi6421v530
 voltage regulator
In-Reply-To: <CABxcv=kP7XLDhUifwDBEfnayfgjGJFf7v9kUkPS6pcLKiaLP-g@mail.gmail.com>
References: <20170526063518.21246-1-guodong.xu@linaro.org>
 <20170526063518.21246-5-guodong.xu@linaro.org>
 <CABxcv=kP7XLDhUifwDBEfnayfgjGJFf7v9kUkPS6pcLKiaLP-g@mail.gmail.com>
Message-ID: <CAFGCpxw3orr+4OO2_YVj2DrAJsvo9O+WiGeVv6GAk26HLzAnRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 8:13 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> Hello Guodong,
>
> On Fri, May 26, 2017 at 8:35 AM, Guodong Xu <guodong.xu@linaro.org> wrote:
>> From: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
>>
>
> [snip]
>
>>
>> +config REGULATOR_HI6421V530
>> +       tristate "HiSilicon Hi6421v530 PMIC voltage regulator support"
>
> The Kconfig symbol is tristate so the driver can be built as a module...
>
>> +
>> +static struct platform_driver hi6421v530_regulator_driver = {
>> +       .driver = {
>> +               .name   = "hi6421v530-regulator",
>> +       },
>> +       .probe  = hi6421v530_regulator_probe,
>> +};
>> +module_platform_driver(hi6421v530_regulator_driver);
>
> ... but the driver doesn't have a platform device ID table nor export
> it as a module alias using MODULE_DEVICE_TABLE().
>

I will add that.
Thanks for your review.

-Guodong

> That means that if built as a module, it won't be autoloaded when the
> "hi6421v530-regulator" device is registered by the MFD driver.
>
>> +
>> +MODULE_AUTHOR("Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>");
>> +MODULE_DESCRIPTION("Hi6421v530 regulator driver");
>> +MODULE_LICENSE("GPL v2");
>
> Alternative you can add a MODULE_ALIAS().
>
> Best regards,
> Javier
