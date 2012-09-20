From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Sep 2012 21:28:20 +0200
Subject: [PATCH v4 03/10] pinctrl: mvebu: kirkwood pinctrl driver
In-Reply-To: <201209201530.40974.arnd@arndb.de>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <50559737.8000705@gmail.com>
 <CACRpkdY-Nyn73EJLvE1RsL4hgMRm6hALtnS-eKAXU7edot2V9A@mail.gmail.com>
 <201209201530.40974.arnd@arndb.de>
Message-ID: <CACRpkdZYr2B83e3mBmMkO8Ai3xU_QGevfbSOSNoTvK3Lz6y6mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 5:30 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> A corner case is the one where you have different versions of the same
> IP block (e.g. the pinctrl) and the kernel cannot find out which one it
> is by looking at registers inside it or on the parent bus, but only
> by looking at other hardware (CPU core revision, or PCI device ID of
> the root complex).

So this is the case I'm thinking of. We have e.g. differens small flags
through platform data depending on cpu_is_ux* in the ux500.

Currently we modify platform data in the board files, just as we
switch some cache handling etc as we know this or that
ASIC has different sized cache.

> We have a precedent of at91 doing this, but I don't
> like it too much because that still means having to change the driver
> again if you get a new SoC with the same IP block but a different version
> register,

I don't like that either.

> To avoid that, I'd prefer using separate "compatible"
> values, at least if the hardware is already described in separate .dtsi
> files.

So what I'm after is whether in this case statically encoding this
onto the .dtsi files is the right thing to do, or whether the boot loader
or kernel should runtime-modify the device tree, patching in
the ASIC-specific info, just like device tree files can override
properties from include files.

Or if this is a bad idea.

Nobody is doing that right now AFAICT, but it is surely possible....

Yours,
Linus Walleij
