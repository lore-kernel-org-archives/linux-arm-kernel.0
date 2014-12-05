From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 5 Dec 2014 11:17:27 +0100
Subject: [PATCH 1/2] pinctrl: at91: allow disabled gpio controllers
In-Reply-To: <20141203150814.GD2714@ldesroches-Latitude-E6320>
References: <1417193367-12422-1-git-send-email-ludovic.desroches@atmel.com>
 <CACRpkdbXuXyfwAyFTHVDGa4OS88KsHXZeDDAeXf6ZJ_JQmduoQ@mail.gmail.com>
 <20141203150814.GD2714@ldesroches-Latitude-E6320>
Message-ID: <CACRpkdbkUUzVVMp14szY+vGNd+d+8bL066STh_XMGud-UsFBqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 3, 2014 at 4:08 PM, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> On Mon, Dec 01, 2014 at 02:56:22PM +0100, Linus Walleij wrote:

>> Remobe these calls, and instead in at91_gpio_probe() in the same
>> file, call gpiochip_add_pingroup_range() for each GPIO chip.
>>
>> That way the GPIO ranges are inserted from the GPIO side instead
>> of the pinctrl side, which is way better, since it is more relative,
>> and make you only add ranges for the gpio chips actually there.
>
> I had a quick look to Documentation about that stuff, I totally agree
> that it is a better approach. Before going further I was wondering if it
> would not cause backward compatibility issue with old dtb (it seems I'll
> have to add some properties to gpio controllers).

The gpiolib core code parses and add ranges when using device tree,
and that is part of the core gpio bindings.

I think you should just try to add in the ranges in the dts nodes for
the gpiochips, remove the  pinctrl_add_gpio_range() calls and see
what happens.

Yours,
Linus Walleij
