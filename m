From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 19 Dec 2010 22:03:11 +0100
Subject: [PATCH 00/20] ux500: platform data, TC3589x keypad driver
In-Reply-To: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
References: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <AANLkTi=7_HKdj6zZVeMu-55FCHPUND+cd1hFs-6bk=p0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OK so after a second spin over these patches...

2010/12/3 Sundar Iyer <sundar.iyer@stericsson.com>:

> Rabin Vincent (1):
> ?nomadik-gpio: allow sleep mode dir/pull to differ from normal mode
>
> Sundar Iyer (19):
> ?mfd/ab8500: remove spi support
>  mach-ux500: move keymaps to new file
>  mach-ux500: add STMPE1601 platform data
>  mach-ux500: explicit enable MTU TCR in the kernel
>  mach-ux500: clean up checkpatch spits

Merged to ux500-core for testing in -next.

> ?mach-ux500: deprecate spi support for ab8500

Want Sam to merge this to the MFD tree.

> ?mfd/tc35892: rename tc35892 header to tc3589x
> ?mfd/tc35892: rename tc35892 core driver to tc3589x
> ?mfd/tc3589x: rename tc35892 structs/registers to tc359x
> ?mfd/tc3589x: add block identifier for multiple child devices
> ?mfd/tc3589x: fix random interrupt misses
> ?mfd/tc3589x: undo gpio module reset during chip init
> ?mfd/tc3589x: add suspend/resume support

I assume all of this was in the partly rewritten
tc35892->tc3589x refactoring I merged into ux500-core
with Sam's Acked-by:

>  plat-nomadik/gpio: add expander gpio pins enumeration

Dropped, Rabin merged another version.

> ?mach-ux500: add touchscreen interfaces platform data

Pending that the staging tree containing the RMI4 driver
gets merged first. This patch will probably have to either
get merged through Gregs tree (probably hard because he
needs to refactor the ux500-core files in his tree which
will screwup) or wait till next merge cycle or -rc1.

> ?i2c/nomadik: add adapter name for updated sanity checkings

Dropped because there is already a similar patch pending
which I submitted independently when I saw the same boot
error...

>  input/tc3589x: add tc3589x keypad support
> ?mach-ux500: add TC35893 keypad platform data

Pending review of the TC35893 keypad input driver.
Will be happy to merge this once we have Dmirtry's
Acked-by:

> ?i2c/nomadik: some checkpatch warnings

Please send this to the I2C maintainers...

Did I get everything right?

Yours,
Linus Walleij
