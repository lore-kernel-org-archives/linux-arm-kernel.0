From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Nov 2013 11:29:15 +0100
Subject: [PATCH v6 4/8] ARM: dts: imx27 pinctrl
In-Reply-To: <20131108135601.GA30263@pengutronix.de>
References: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
 <1382950843-26066-5-git-send-email-mpa@pengutronix.de>
 <CAHCPf3sz6eOYrnNDfOTo5Z5dZP2U9+GtQMKYZEb-1WfuXepa6A@mail.gmail.com>
 <CACRpkdazhujHpjVuOhee9UXfi=zV3Z7TjbxzQ_3H+gmFrgDmWA@mail.gmail.com>
 <20131108135601.GA30263@pengutronix.de>
Message-ID: <CACRpkda2dO6DvurEhaTVGJv8nDyEGOEeLCap-_+1e1mHtD0XyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 8, 2013 at 2:56 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
> On Fri, Nov 08, 2013 at 10:45:01AM +0100, Linus Walleij wrote:

>> If the I/O region is tightly coupled across two subsystems like
>> that we usually merge the driver into one combined
>> pinctrl+gpio driver and put it into drivers/pinctrl/*.
>
> The gpio module does not necessarily include a pinctrl module. Most of
> the imx SoCs have the same gpio function registers but without pinctrl.
> They all use the same gpio driver.

Yeah but I'm only saying you could make a combined driver,
I didn't say you had to use both halves of it all the time.

pinctrl/pinctrl-imx1.c can very well handle both and only
supply GPIO functionality for some compatible-strings,
that's OK.

> There are 6 gpio modules in the memory region from 0x10015000 to
> 0x100155ff. pinctrl is in the same memory region.

OK I get it (I think).

> I could change the bindings back to that from v1 [1]. One pinmux
> controller over the full memory range (0x10015000 0x600) and the gpio
> modules as subnodes using 0x100 each. This would preserve the currently
> used references to the gpio nodes.

Hm I don't really have opinions on this, better let the DT-folks
say what they prefer. But that looks good to me.

Can you do this with an incremental patch?

Yours,
Linus Walleij
