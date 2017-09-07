From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 7 Sep 2017 10:11:42 +0900
Subject: [PATCH v3] gpio: uniphier: add UniPhier GPIO controller driver
In-Reply-To: <CACRpkdYG3BFhhpouwAkQN+x0YpC5EhsVhTkqyuNdRd26Ne-r9A@mail.gmail.com>
References: <1503418601-9728-1-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdYG3BFhhpouwAkQN+x0YpC5EhsVhTkqyuNdRd26Ne-r9A@mail.gmail.com>
Message-ID: <CAK7LNAS0CEcS=DReDWj2xhKKy4_QMSu_m=Rc-DELsaj3T73uPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


2017-08-31 22:41 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Aug 22, 2017 at 6:16 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>
>> This GPIO controller device is used on UniPhier SoCs.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> Changes in v3:
>>   - Add .irq_set_affinity() hook
>>   - Use irq_domain_create_hierarchy() instead of legacy
>>     irq_domain_add_hierarchy().
>
> This is getting better and better.
>
>> +static const u32 uniphier_gpio_irq_parent_hwirqs[] = {
>> +       48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
>> +       154, 155, 156, 157, 158, 217, 218, 219,
>> +};
>
> This array which is used when allocating the hierarchical domain
> looks like configuration data. Why is it not in the device tree?
>


Another solution might be
to use the brand-new irq_domain_push_irq().


With a quick look at it, the hierarchy IRQ domain can work with
#interrupts property by inserting the outer-most irq_data with
irq_domain_push_irq().


If you are unhappy with hard-coded configuration parameters,
I will switch to generic compatible + DT properties approach.


-- 
Best Regards
Masahiro Yamada
