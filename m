From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Sep 2013 09:42:07 +0200
Subject: [PATCH 0/8] IOP GPIO refactoring
In-Reply-To: <20130910141434.GD3379@blackmetal.musicnaut.iki.fi>
References: <1378741198-12847-1-git-send-email-linus.walleij@linaro.org>
 <20130910141434.GD3379@blackmetal.musicnaut.iki.fi>
Message-ID: <CACRpkday=enekKjbf5QTA_JCh6mvX7-_XuaHp884bzCg7HfkzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 4:14 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:

> On Mon, Sep 09, 2013 at 05:39:58PM +0200, Linus Walleij wrote:
>> This series refactor the IOP GPIO driver to move down to the
>> GPIO subsystem, instatiate as a platform device, remap its
>> I/O address, and kills off the <mach/gpio.h> dependency.
>
> Patches 1-5 work on N2100. However, when pressing the power button there
> is a warning:
>
> [   31.995575] reboot: Restarting system
> [   32.023422] ------------[ cut here ]------------
> [   32.051596] WARNING: CPU: 0 PID: 251 at drivers/gpio/gpiolib.c:160 gpio_ensure_requested+0x64/0xc0()
> [   32.110436] ---[ end trace 6b2c83f883af871f ]---

Hm, this does not appear right after 1/8 or 2/8 right?
I'd rather expect that after 3/8 "ARM: iop32x: read N2100 power key
using gpiolib"
and then you should have error messages like this in dmesg:

could not request reset GPIO

Correct?

> With patch 6 it starts to crash on first gpio_get_value(), I guess
> because gpio-iop platform device is not registered on N2100...?

Probably because something is trying to read a GPIO before this device
is up, I'll look into this.

THANKS!

Yours,
Linus Walleij
