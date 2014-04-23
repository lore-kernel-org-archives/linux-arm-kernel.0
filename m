From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 24 Apr 2014 06:55:49 +0800
Subject: [PATCH 3/4] gpio: make handler_data configurable while using
 gpiolib_irqchip
In-Reply-To: <CACRpkdb8rmMDXS1kfcq7wgOnG2XsPm_bxb15z9_9d3E+trBfQA@mail.gmail.com>
References: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
 <1397544229-20545-4-git-send-email-21cnbao@gmail.com>
 <CACRpkdb8rmMDXS1kfcq7wgOnG2XsPm_bxb15z9_9d3E+trBfQA@mail.gmail.com>
Message-ID: <CAGsJ_4wmd-ejfHF+MXbO3JSppUDYcEVKeO1WxRM16FtSFEBxpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-24 4:13 GMT+08:00 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Apr 15, 2014 at 8:43 AM, Barry Song <21cnbao@gmail.com> wrote:
>
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> since it is called handler_data, drivers should have the ability to
>> set handler_data based on real hardware.
>> GPIOLIB_IRQCHIP doesn't use handler_data by itself, so it will not
>> break GPIO core.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> NAK, the whole idea with the function gpiochip_set_chained_irqchip()
> is that its sets things up so that the gpiochip is passed as handler
> data on the parent IRQ, akin to how the gpiochip is passed as
> chip data on the cascaded IRQs.

i think it is a really bad idea as the parent handler might not want
the whole chip if the chip has several parents and each parent want a
separate handler_data.
this patch doesn't break your way as the parameter is void *, drivers
which use your way don't need any change. but for drivers which want
more special handler_data, it supports better.

>
> Yours,
> Linus Walleij
-barry
