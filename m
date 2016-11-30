From: wsa-dev@sang-engineering.com (Wolfram Sang)
Date: Wed, 30 Nov 2016 17:23:53 +0100
Subject: [PATCH v3 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <CAOAejn0BZNH82kY_7UR1EjV7M1G+9jGihGb4-uCs9=XiPHUYxQ@mail.gmail.com>
References: <1466439771-2741-1-git-send-email-cedric.madianga@gmail.com>
 <1466439771-2741-3-git-send-email-cedric.madianga@gmail.com>
 <20160722070219.GB1605@katana>
 <CAOAejn0BZNH82kY_7UR1EjV7M1G+9jGihGb4-uCs9=XiPHUYxQ@mail.gmail.com>
Message-ID: <20161130162353.GC1441@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> I was too busy in another project but now I am ready to complete the
> upstream of the STM32F4 I2C driver.

Nice.

> >> +static void stm32f4_i2c_set_periph_clk_freq(struct stm32f4_i2c_dev *i2c_dev)
> >> +{
> >> +     u32 clk_rate, cr2, freq;
> >> +
> >> +     cr2 = readl_relaxed(i2c_dev->base + STM32F4_I2C_CR2);
> >> +     cr2 &= ~STM32F4_I2C_CR2_FREQ_MASK;
> >> +
> >> +     clk_rate = clk_get_rate(i2c_dev->clk);
> >> +     freq = clk_rate / MHZ_TO_HZ;
> >> +
> >> +     if (freq > STM32F4_I2C_MAX_FREQ)
> >> +             freq = STM32F4_I2C_MAX_FREQ;
> >> +     if (freq < STM32F4_I2C_MIN_FREQ)
> >> +             freq = STM32F4_I2C_MIN_FREQ;
> >
> > clamp() to enforce the range?
> Sorry but what do you mean by "clamp()" ?

The kernel has a clamp() function which would fit this purpose, I think.

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161130/e13dca49/attachment.sig>
