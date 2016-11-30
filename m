From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Wed, 30 Nov 2016 18:07:41 +0100
Subject: [PATCH v3 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <20161130162353.GC1441@katana>
References: <1466439771-2741-1-git-send-email-cedric.madianga@gmail.com>
 <1466439771-2741-3-git-send-email-cedric.madianga@gmail.com>
 <20160722070219.GB1605@katana>
 <CAOAejn0BZNH82kY_7UR1EjV7M1G+9jGihGb4-uCs9=XiPHUYxQ@mail.gmail.com>
 <20161130162353.GC1441@katana>
Message-ID: <CAOAejn2UDbsLRLmthOitTtkWOcN97WYhg93r9nyxQdBzGGegcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


2016-11-30 17:23 GMT+01:00 Wolfram Sang <wsa-dev@sang-engineering.com>:
> Hi,
>
>> I was too busy in another project but now I am ready to complete the
>> upstream of the STM32F4 I2C driver.
>
> Nice.
>
>> >> +static void stm32f4_i2c_set_periph_clk_freq(struct stm32f4_i2c_dev *i2c_dev)
>> >> +{
>> >> +     u32 clk_rate, cr2, freq;
>> >> +
>> >> +     cr2 = readl_relaxed(i2c_dev->base + STM32F4_I2C_CR2);
>> >> +     cr2 &= ~STM32F4_I2C_CR2_FREQ_MASK;
>> >> +
>> >> +     clk_rate = clk_get_rate(i2c_dev->clk);
>> >> +     freq = clk_rate / MHZ_TO_HZ;
>> >> +
>> >> +     if (freq > STM32F4_I2C_MAX_FREQ)
>> >> +             freq = STM32F4_I2C_MAX_FREQ;
>> >> +     if (freq < STM32F4_I2C_MIN_FREQ)
>> >> +             freq = STM32F4_I2C_MIN_FREQ;
>> >
>> > clamp() to enforce the range?
>> Sorry but what do you mean by "clamp()" ?
>
> The kernel has a clamp() function which would fit this purpose, I think.
Ok I got it. I will fix it in the V4.
Thanks

>
> Regards,
>
>    Wolfram
>
