From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Jan 2013 11:10:08 +0100
Subject: [PATCH v7 08/15] gpio: pl061: bind pinctrl by gpio request
In-Reply-To: <CAD6h2NQM6=wZ5k7p9yhF3oWGQGBcsn+gt3J0+JVxx7wKYaKEJg@mail.gmail.com>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-9-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdZo6mVSaHBr6PJt8QCkiKp-Vs7mWup8n=4zyacRwf8V3g@mail.gmail.com>
 <CAD6h2NQm+VoUv9tDSoHv3Xs8RtuCt5A+_DCBx6bh-d3WP3PK=w@mail.gmail.com>
 <CACRpkdbgRY9CcdRAVVaVAq57hF1cTf7LMOqneNwcz+VtpFDcUg@mail.gmail.com>
 <CAD6h2NQM6=wZ5k7p9yhF3oWGQGBcsn+gt3J0+JVxx7wKYaKEJg@mail.gmail.com>
Message-ID: <CACRpkdZSKH=7a5Kf-NM964YNW0UynDv0ih6=iEqX7pXBSQ5xCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 10:55 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

>> Add a function to gpiolib.c to check if a certain gpio is in the range
>> of the current chip.
>>
>> Then use that:
>>
>> if (gpio_in_pinrange(gpio))
>>     pinctrl_request_gpio(gpio);
>>
>> Yours,
>> Linus Walleij
>
> It seems better. I'll update it.

Hm the function above will need to pass the chip as parameter as
well, so a bit simplified.

Maybe it's better to add a function like gpio_check_pinctrl_backend(chip, gpio);
that does the above two statements?

Yours,
Linus Walleij
