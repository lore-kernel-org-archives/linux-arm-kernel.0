From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 7 Jan 2012 16:18:33 +0530
Subject: [PATCH] backlight: lcd: add driver for raster-type lcd's with
 gpio controlled panel reset
In-Reply-To: <001401cccc19$25b52920$711f7b60$%han@samsung.com>
References: <1325778146-27056-1-git-send-email-thomas.abraham@linaro.org>
 <001401cccc19$25b52920$711f7b60$%han@samsung.com>
Message-ID: <CAJuYYwR9vCohqW91p6_fPw39h-yuxN7cfvhM6s=9bnzPyDKgBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mr. Han,

On 6 January 2012 07:46, Jingoo Han <jg1.han@samsung.com> wrote:
> Hi, Thomas.
[...]

>> ?obj-$(CONFIG_LCD_PLATFORM) ? ? ?+= platform_lcd.o
>> +obj-$(CONFIG_LCD_PWRCTRL) ? ? ? += lcd_pwrctrl.o
> Can you remove unnecessary space?
> Please use <tab><space><space><space> instead of <space><tab><space><space><space>
> between PWRCTRL) and += lcd_.

Ok. I will fix that.

>> [...]
>> +static struct platform_driver lcd_pwrctrl_driver = {
>> + ? ? .driver ? ? ? ? = {
>> + ? ? ? ? ? ? .name ? = "lcd-pwrctrl",
>> + ? ? ? ? ? ? .owner ?= THIS_MODULE,
>> + ? ? ? ? ? ? .of_match_table = of_match_ptr(lcd_pwrctrl_match),
>> + ? ? },
>> + ? ? .probe ? ? ? ? ?= lcd_pwrctrl_probe,
>> + ? ? .remove ? ? ? ? = lcd_pwrctrl_remove,
>> + ? ? .suspend ? ? ? ?= lcd_pwrctrl_suspend,
>> + ? ? .resume ? ? ? ? = lcd_pwrctrl_resume,
> Please use 'struct dev_pm_ops'.

Ok.

>> +};
>> +
>> +static int __init lcd_pwrctrl_init(void)
>> +{
>> + ? ? return platform_driver_register(&lcd_pwrctrl_driver);
>> +}
>> +
>> +static void __exit lcd_pwrctrl_cleanup(void)
>> +{
>> + ? ? platform_driver_unregister(&lcd_pwrctrl_driver);
>> +}
>> +
>> +module_init(lcd_pwrctrl_init);
>> +module_exit(lcd_pwrctrl_cleanup);
> Use module_platform_driver(lcd_pwrctrl_driver).
> It can make the code simpler.

Ok. Thanks for your review Mr. Han. I will do the required changes.

Regards,
Thomas.
