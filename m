From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Oct 2012 17:12:27 +0200
Subject: [PATCH 0/8] Convert Ux500 to SPARSE_IRQ
In-Reply-To: <201210190742.58900.arnd@arndb.de>
References: <1350580695-8303-1-git-send-email-linus.walleij@stericsson.com>
 <201210190742.58900.arnd@arndb.de>
Message-ID: <CACRpkdbd67pHDV2GQUp6KCrw7OO7LX6UsjBQNb2VZudisGCK8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 9:42 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 18 October 2012, Linus Walleij wrote:

>> After this series I tried turning on multiplatform for ux500
>> but there are still headers in <mach/*> creating problems
>> so we are still just halfway.
>
> Which ones are still left? This is the list of inclusions I saw
> in the 3.6-rc1 version of my multiplatform branch being included
> from outside of the mach-ux500 directory.
>
> I should probably redo that branch to see which ones are gone now,
> but you would also catch most of these with a simple defconfig build.
>
>       3 include <mach-ux500/board-mop500-msp.h>
>       2 include <mach-ux500/crypto-ux500.h>
>       1 include <mach-ux500/db8500-regs.h>
>       1 include <mach-ux500/gpio.h>
>       8 include <mach-ux500/hardware.h>

This is the one causing the build to fail.

>       3 include <mach-ux500/id.h>

I'm working on a patch for this one.

>       3 include <mach-ux500/irqs.h>
>       1 include <mach-ux500/setup.h>
>       1 include <mach-ux500/usb.h>

Basically I think it's pretty easy to hack something that builds
multiplatform on top of the SPARSE_IRQ patch set.
I just need to do it :-) (famous last words...)

Yours,
Linus Walleij
