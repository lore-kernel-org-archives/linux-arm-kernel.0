From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 28 Jan 2013 13:29:28 +0200
Subject: [PATCH 05/10] gpio: pxa: remove gpio_type
In-Reply-To: <CACRpkdYj3Bm0GKhdvcmvwu4mz3YLTnyaOWjGT7qt2atbZ_x2EA@mail.gmail.com>
References: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
 <1358929554-32265-6-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdYj3Bm0GKhdvcmvwu4mz3YLTnyaOWjGT7qt2atbZ_x2EA@mail.gmail.com>
Message-ID: <51066118.1000200@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/13 12:01, Linus Walleij wrote:
> On Wed, Jan 23, 2013 at 9:25 AM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
> 
>> Since gpio_type is used to check whether gafr register is valid. So
>> move it into platform data.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> 
> (...)
> 
>> +++ b/drivers/gpio/gpio-pxa.c
>> @@ -72,6 +72,7 @@ struct pxa_gpio_chip {
>>         void __iomem    *regbase;
>>         unsigned int    irq_base;
>>         unsigned int    inverted;
>> +       unsigned int    gafr;
>>         char label[10];
> 
> Also looks like some kind of a bool.

Actually, no... GAFR is the PXA Alternate Function register name,
so unsigned int (or u32) is good.


-- 
Regards,
Igor.
