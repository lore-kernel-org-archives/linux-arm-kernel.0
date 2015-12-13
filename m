From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 13 Dec 2015 21:15:01 +0100
Subject: [PATCH 004/182] gpio: generic: factor into gpio_chip struct
In-Reply-To: <20151209230852.GB28304@deathstar>
References: <1449666760-29876-1-git-send-email-linus.walleij@linaro.org>
 <20151209230852.GB28304@deathstar>
Message-ID: <CACRpkdZxGYaRJ_LY0jjHkb67j70Aws53ec2DtwrOzdBfEOj5gQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 12:08 AM, Michael Welling <mwelling@ieee.org> wrote:
> On Wed, Dec 09, 2015 at 02:12:40PM +0100, Linus Walleij wrote:
> ...
>> -     ret = gpiochip_add(&bgc->gc);
>> +     ret = gpiochip_add_data(gc, NULL);
>>       if (ret) {
>
> gpiochip_add is still mentioned in the dev_err below.

I explicitly left text string updates aside, I am anyways going to have to go
over all drivers for a second refactoring with gpiodev_alloc() etc.

Yours,
Linus Walleij
