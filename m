From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Sep 2011 21:23:45 +0200
Subject: [PATCH v2] gpio: rewrite U300 GPIO to use gpiolib
In-Reply-To: <CAGsJ_4w2fCjnA99bFixWU6CTv+TWSR16c2-+Qfe=u31LHq8dRg@mail.gmail.com>
References: <1315383085-26352-1-git-send-email-linus.walleij@stericsson.com>
	<CAGsJ_4w2fCjnA99bFixWU6CTv+TWSR16c2-+Qfe=u31LHq8dRg@mail.gmail.com>
Message-ID: <CAKnu2MpKw5ynpqxziOgsBqqitobBE51vCDBW-8ArOeRVcTEkVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/7 Barry Song <21cnbao@gmail.com>:

>> - ? ? ? /* Enable or disable the internal pull-ups in the GPIO ASIC block */
>> - ? ? ? for (i = 0; i < U300_GPIO_MAX; i++) {
>> - ? ? ? ? ? ? ? val = 0;
>> - ? ? ? ? ? ? ? for (j = 0; j < 8; j++)
>> - ? ? ? ? ? ? ? ? ? ? ? val |= (u32)((u300_gpio_config[i][j].pull_up == DISABLE_PULL_UP) << j);
>> - ? ? ? ? ? ? ? local_irq_save(flags);
>> - ? ? ? ? ? ? ? writel(val, virtbase + U300_GPIO_PXPER + i * U300_GPIO_PORTX_SPACING);
>> - ? ? ? ? ? ? ? local_irq_restore(flags);
>
> this has used array/table to set the pull of gpio. so what's our plan
> about api to config GPIO pull dynamically?

My plan is as follows:

1) Introduce the pin control subsystem, support pinmux in it to
  begin with

2) Add support for biasing and driving (etc) through pin control

3) Move the driver over to drivers/pinctrl, have it register both
  a pin control and a GPIO interface as well

Sounds OK?

Yours,
Linus Walleij
