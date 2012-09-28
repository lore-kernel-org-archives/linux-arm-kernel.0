From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Sep 2012 13:34:18 +0200
Subject: [PATCH RFC 1/2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <50657356.4010801@antcom.de>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
 <CACRpkdZ+1ffsMDRZXYb5RRndoXstj_QHvHOpeikRY0bas72dKQ@mail.gmail.com>
 <50657356.4010801@antcom.de>
Message-ID: <CACRpkdbEgBqSdZmebw+PBMo9G_Y24mgz17=dp11VrbKf5fKyDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 11:52 AM, Roland Stigge <stigge@antcom.de> wrote:

> It's hard to do the one-value-per-file right for a several-gpios-at-once
> goal. :-)

That's true. This is one of the reasons I think GPIO chips should
be /dev/gpioN device nodes and this business be handled by
ioctl():s instead, it is harder from an ABI point of view but can
do several things at once.

> I originally had a one-value solution: A bit map, continuously
> hex coded, like in the original kernel API idea (e.g. 0x000F0A0010).
> Wasn't sure because it encodes GPIO numbers in a weird way.

Yeah, well that is not so nice either.

> Strictly formally: Isn't a comma-separated list of a GPIO block (e.g.
> "80,81,85") a singe value in a sense? :-)

I think it's called an array ...

> Or other possibilities? Maybe
> some node in /proc?

Heaven's no.

> Or some kind of new character device node?

Yes, I don't know if we should create /dev/gpioN or /dev/pinctrlN for
this, and add GPIO functions to pinctrl (while wrapping it in the
gpiolib to aid migration) the latter would encourage users of the
new ABI to switch to writing pinctrl drivers.

> Otherwise, I need to think about leaving out the sysfs for this purpose.

Do you really need it?

Yours,
Linus Walleij
