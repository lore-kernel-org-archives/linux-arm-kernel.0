From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Aug 2016 11:09:15 +0200
Subject: [PATCH 2/4] soc: qcom: add EBI2 driver
In-Reply-To: <20160818140717.7b5c2bbd@ipc1.ka-ro>
References: <1470691445-27571-1-git-send-email-linus.walleij@linaro.org>
 <1470691445-27571-3-git-send-email-linus.walleij@linaro.org>
 <20160818140717.7b5c2bbd@ipc1.ka-ro>
Message-ID: <CACRpkdZCsCXWq4DfZSLzduHnpMPVUkmiZMDG8LjGcTHwgYEKkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 2:07 PM, Lothar Wa?mann <LW@karo-electronics.de> wrote:

>> +#define EBI2_CSN_MASK BIT(2)|BIT(3)|BIT(4)|BIT(5)|BIT(6)|BIT(7)
>> +
> missing '()' around expression, otherwise...
>
>> +     csval &= ~EBI2_CSN_MASK;
> ...this will be '~BIT(2) | BIT(3) | BIT(4) | BIT(5) | BIT(6) | BIT(7)'
> which is most likely NOT what's intended.
>
> (Also spaces around the '|' operator would improve readability)

Sorry for not mentioning in my latest v2 revision: I solved this
by using GENMASK(0,9) (yeah it also turns out to be more
than 8 bits of CS...)

Yours,
Linus Walleij
