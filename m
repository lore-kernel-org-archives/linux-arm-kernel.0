From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Oct 2012 12:45:33 +0200
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <20121023102903.GA24820@arwen.pp.htv.fi>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121022155028.GA13791@core.coreip.homeip.net>
 <CACRpkdaQ1WfRWrx=RXMVkeFtwdERJsOpVa3DaXBTU2KZdgqhRQ@mail.gmail.com>
 <508664CA.7000601@ti.com>
 <CACRpkdbhCS-Vb0DtbTZQ_Zw_8SOh3Bqutme3Y2-QrxNqvMiNNw@mail.gmail.com>
 <20121023100333.GA24418@arwen.pp.htv.fi>
 <20121023122312.56b23e1c@skate>
 <CACRpkdb+f44jw1vTYvJT0bnMOP8XQe8ztDUHiwtS2JHtPWAGXw@mail.gmail.com>
 <20121023102903.GA24820@arwen.pp.htv.fi>
Message-ID: <CACRpkdZhUwMTg0suqbZiukN7Se6fzdYP3-0Dspm9WF6qZniNVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 12:29 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Tue, Oct 23, 2012 at 12:29:28PM +0200, Linus Walleij wrote:

>> So the biggest implementation of the notifier approach to resource
>> handling is the SH clock thing:
>> drivers/base/power/clock_ops.c
>
> that's different right ? It's just creating the list of clocks, device
> drivers still have to call pm_clk_add().
>
> That's ok, I guess, otherwise all struct device would allocate memory
> which hardly ever used (so far).

Hm so I have had this idea of runtime PM core helping out
with pins, so I could add something like

pm_pins_fetch()
pm_pins_default()
pm_pins_idle()
pm_pins_sleep()

So if one is using the pin states defined in <linux/pinctrl/pinctrl-state.h>
then the PM core can help out in keeping track of the pins
and states, and the driver will just tell the PM core what
to do and when.

Would this fit the bill for everyone's code consolidation needs?
It would sure work for us...

It however require that no custom states are used and that we
keep to the state semantics I just happen to think is most
common.

Yours,
Linus Walleij
