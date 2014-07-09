From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Jul 2014 12:14:42 +0200
Subject: [PATCH 0/5] Introduce a managed function for gpio_request_array
In-Reply-To: <cover.1404665589.git.himangi774@gmail.com>
References: <cover.1404665589.git.himangi774@gmail.com>
Message-ID: <CACRpkdYbK3tizezXNaTBT6ANQ8fxoBUH5OATpb5cLykQqRSuKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 6, 2014 at 7:46 PM, Himangi Saraogi <himangi774@gmail.com> wrote:

> This patchset intoduces a new managed interface devm_gpio_request_array,
> adds it in the documentation and its declaration in the gpio.h include
> file. Some cases of gpio_request_array are changed to
> devm_gpio_request_array.
>
> Himangi Saraogi (5):
>   gpiolib: devres: Introduce the function devm_request_gpio_array
>   ASoC: wm1250-ev1: Use devm_gpio_request_array
>   ASoC: pxa: Use devm_gpio_request_array
>   ASoC: pxa: e800_wm9712: Introduce the use of devm_gpio_request_array
>   ASoC: pxa/hx4700: Introduce the use of devm_gpio_request_array

Sorry, we're not encouraging extension of the old gpio* plain API anymore.

The right thing to do is convert users over to using GPIO descriptors
internally, then introduce devm_gpiod_get_array() if that makes some
sense.

Alexandre, what do you say?

Yours,
Linus Walleij
