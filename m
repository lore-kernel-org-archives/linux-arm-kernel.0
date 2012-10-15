From: stigge@antcom.de (Roland Stigge)
Date: Mon, 15 Oct 2012 23:38:48 +0200
Subject: [PATCH RFC 2/6 v3] gpio: Add sysfs support to block GPIO API
In-Reply-To: <CACRpkdZmg4+7Zjm2UJktt1uKvytUW3uaYtKz0nJvLeM2MMSV-Q@mail.gmail.com>
References: <1350069085-13283-1-git-send-email-stigge@antcom.de>
 <1350069085-13283-3-git-send-email-stigge@antcom.de>
 <20121015180702.GA12801@game.jcrosoft.org> <20121015181928.GB27923@kroah.com>
 <CACRpkdZmg4+7Zjm2UJktt1uKvytUW3uaYtKz0nJvLeM2MMSV-Q@mail.gmail.com>
Message-ID: <507C8268.5030409@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/12 22:30, Linus Walleij wrote:
> I don't like it either, basically because the GPIO sysfs is not
> entirely sound.
> 
> Another patch that is circulating concerns edge triggers and similar,
> and it appear that some parts of the GPIO sysfs is for example
> redefining and exporting IRQchip properties like trigger edge
> in sysfs, while the settings of the irqchip actually used by the driver
> is not reflected in the other direction. So you can *set* these things
> by writing in the GPIO sysfs, but never trust what you *read* from
> there. And you can set what edges an IRQ will trigger on a certain
> GPIO, and the way to handle the IRQs from usespace is to poll
> on a value. This is not really documented but well ...

I'm not convinced this generally also applies to the block GPIO patches.
Or that it can't be fixed.

> The reason an ioctl() IMO is better suited to do the job is that
> it can properly represent a multiple-value operation on several
> GPIOs at the same time in a struct, and it can conversely inform
> userspace about which GPIOs may be a block of signals that
> can be fired simultaneously instead of going to string parsing
> and binary values in sysfs which look like worse hacks to me.

There is no binary values in the sysfs for the block GPIO patches, and
regarding string parsing - yes, that's sysfs. :-)

Roland
