From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Oct 2012 07:42:58 +0000
Subject: [PATCH 0/8] Convert Ux500 to SPARSE_IRQ
In-Reply-To: <1350580695-8303-1-git-send-email-linus.walleij@stericsson.com>
References: <1350580695-8303-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201210190742.58900.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 October 2012, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This patch series fixes the prerequisites and then converts Ux500
> to SPARSE_IRQ.

Great stuff! In case any patches end up going through other trees,
please add my

Acked-by: Arnd Bergmann <arnd@arndb.de>

> After this series I tried turning on multiplatform for ux500
> but there are still headers in <mach/*> creating problems
> so we are still just halfway.

Which ones are still left? This is the list of inclusions I saw
in the 3.6-rc1 version of my multiplatform branch being included
from outside of the mach-ux500 directory.

I should probably redo that branch to see which ones are gone now,
but you would also catch most of these with a simple defconfig build.

      3 include <mach-ux500/board-mop500-msp.h>
      2 include <mach-ux500/crypto-ux500.h>
      1 include <mach-ux500/db8500-regs.h>
      1 include <mach-ux500/gpio.h>
      8 include <mach-ux500/hardware.h>
      3 include <mach-ux500/id.h>
      3 include <mach-ux500/irqs.h>
      1 include <mach-ux500/setup.h>
      1 include <mach-ux500/usb.h>

	Arnd
