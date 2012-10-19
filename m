From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Oct 2012 12:29:52 +0200
Subject: [PATCH RFC 2/6 v3] gpio: Add sysfs support to block GPIO API
In-Reply-To: <20121018043848.GA4022@minime.bse>
References: <1350069085-13283-1-git-send-email-stigge@antcom.de>
 <1350069085-13283-3-git-send-email-stigge@antcom.de>
 <20121015180702.GA12801@game.jcrosoft.org>
 <20121015181928.GB27923@kroah.com>
 <CACRpkdZmg4+7Zjm2UJktt1uKvytUW3uaYtKz0nJvLeM2MMSV-Q@mail.gmail.com>
 <20121018043848.GA4022@minime.bse>
Message-ID: <CACRpkdZje-D9RDqDtsmb0DCqBo4fLs+YF=RFbHjtgKn6Co=SsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 6:38 AM, Daniel Gl?ckner <daniel-gl@gmx.net> wrote:
> On Mon, Oct 15, 2012 at 10:30:15PM +0200, Linus Walleij wrote:
>>
>> Another patch that is circulating concerns edge triggers and similar,
>> and it appear that some parts of the GPIO sysfs is for example
>> redefining and exporting IRQchip properties like trigger edge
>> in sysfs, while the settings of the irqchip actually used by the driver
>> is not reflected in the other direction. So you can *set* these things
>> by writing in the GPIO sysfs, but never trust what you *read* from
>> there. And you can set what edges an IRQ will trigger on a certain
>> GPIO, and the way to handle the IRQs from usespace is to poll
>> on a value. This is not really documented but well ...
>
> Part of this sounds like you are not familiar with the GPIOlib sysfs
> IRQ stuff.

Yeah you bet :-)

I'm just trying to maintain it, I think I need your help with this.

Do you think it'd be possible for you to augment the
Documentation/gpio.txt file with some userspace code examples?
I think this could be very useful.

> The trigger edge set in sysfs is only used when userspace
> polls the GPIO via sysfs. Drivers that want to register a gpio IRQ
> should IMHO always explicitly request the edge/level to trigger on and
> they should request the gpio beforehand. This prevents the gpio from
> being exported to userspace. Only IRQ triggers accepted by the irq chip
> are settable in sysfs, so you can trust the value read from that file.

OK.

>> Daniel: are you interested in helping us fixing the GPIOlib
>> sysfs ABI and kernel internals? I'm a bit afraid of it.
>
> Actually I don't know what you want to change to fix the existing sysfs
> ABI. Personally I'd like to see the following things changed:
>  - /sys/gpio/.../direction does not correspond to hardware before first
>    use of gpio_direction_* due to lack of gpio_get_direction.
>  - Names given to gpios by the chip should just result in symlinks to
>    the usual gpioX directories or (un)exporting of gpios should accept
>    names.

Please send a patch! I'll merge.

Actually I'm mostly referring to another floating patch, I will try to
dig it up and CC you.

Yours,
Linus Walleij
