From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Aug 2016 23:47:09 +0200
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <20160830214253.GP1041@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJjz-0000mA-0o@rmk-PC.armlinux.org.uk>
 <CACRpkdZJy9gZwH9__qXAf6nURN7xV6CbOaGC-JL6X5rDHN55VQ@mail.gmail.com>
 <20160830214253.GP1041@n2100.armlinux.org.uk>
Message-ID: <CACRpkdbNn0VXf7bHcfAq2qe2WpiZUxO-HRvikh4nv-svgJf+pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 11:42 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Aug 30, 2016 at 11:25:19PM +0200, Linus Walleij wrote:

>> > +#define to_gpio_reg(x) container_of(x, struct gpio_reg, gc)
>>
>> You don't need that trickery anymore, just:
>>
>> > +static int gpio_reg_get_direction(struct gpio_chip *gc, unsigned offset)
>> > +{
>> > +       struct gpio_reg *r = to_gpio_reg(gc);
>>
>> struct gpio_reg *r = gpiochip_get_data(gc);
>>
>> (applied everywhere)
>
> I prefer my method by a long shot

Sure it's no strong preference. Keep it like this if you like.
I'm very happy with the series either way!

Yours,
Linus Walleij
