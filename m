From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 Oct 2012 16:04:28 +0200
Subject: [PATCH 1/2] ARM: config: sort select statements alphanumerically
In-Reply-To: <E1TMfFr-0001Kt-W5@rmk-PC.arm.linux.org.uk>
References: <20121012132553.GK28061@n2100.arm.linux.org.uk>
 <E1TMfFr-0001Kt-W5@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdba1q52bEDcWsd47QwXA-DNhq6PENf2M-tvZ6znYu+5yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2012 at 3:26 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> As suggested by Andrew Morton:
>
>   This is a pet peeve of mine.  Any time there's a long list of items
>   (header file inclusions, kconfig entries, array initalisers, etc) and
>   someone wants to add a new item, they *always* go and stick it at the
>   end of the list.
>
>   Guys, don't do this.  Either put the new item into a randomly-chosen
>   position or, probably better, alphanumerically sort the list.
>
> lets sort all our select statements alphanumerically.  This commit was
> created by the following perl:

I applied this and tried to configure the Nomadik defconfig,
and I get this, sadly:

make -f Makefile ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-
KBUILD_OUTPUT=/var/linus/linux/build-nomadik nhk8815_defconfig
make[1]: Entering directory `/var/linus/linux'
  GEN     /var/linus/linux/build-nomadik/Makefile
arch/arm/mach-footbridge/Kconfig:29: syntax error
arch/arm/mach-footbridge/Kconfig:28: unknown option "Saying"
arch/arm/mach-footbridge/Kconfig:31: syntax error
arch/arm/mach-footbridge/Kconfig:30: unknown option "The"
arch/arm/mach-footbridge/Kconfig:31: unknown option "There"
arch/arm/mach-footbridge/Kconfig:32: unknown option "prototypes"
arch/arm/mach-footbridge/Kconfig:35: syntax error
arch/arm/mach-footbridge/Kconfig:34: unknown option "http"
arch/arm/mach-footbridge/Kconfig:37: syntax error
arch/arm/mach-footbridge/Kconfig:36: unknown option "If"
arch/arm/mach-footbridge/Kconfig:37: unknown option "Server"
arch/arm/mach-pxa/Kconfig:18: syntax error
arch/arm/mach-pxa/Kconfig:3: missing end statement for this entry
arch/arm/mach-pxa/Kconfig:3: missing end statement for this entry
arch/arm/Kconfig:245: missing end statement for this entry
arch/arm/mach-pxa/Kconfig:17: invalid statement
arch/arm/mach-pxa/Kconfig:632: unexpected end statement
arch/arm/mach-pxa/Kconfig:634: syntax error
arch/arm/mach-pxa/Kconfig:633: unexpected option "select"
arch/arm/mach-pxa/Kconfig:634: unexpected option "select"
arch/arm/mach-pxa/Kconfig:733: unexpected end statement
arch/arm/Kconfig:1416: unexpected end statement
make[3]: *** [nhk8815_defconfig] Error 1
make[2]: *** [nhk8815_defconfig] Error 2
make[1]: *** [sub-make] Error 2
make[1]: Leaving directory `/var/linus/linux'
make: *** [config-base] Error 2make -f Makefile ARCH=arm
CROSS_COMPILE=arm-linux-gnueabi-
KBUILD_OUTPUT=/var/linus/linux/build-nomadik nhk8815_defconfig
make[1]: Entering directory `/var/linus/linux'
  GEN     /var/linus/linux/build-nomadik/Makefile
arch/arm/mach-footbridge/Kconfig:29: syntax error
arch/arm/mach-footbridge/Kconfig:28: unknown option "Saying"
arch/arm/mach-footbridge/Kconfig:31: syntax error
arch/arm/mach-footbridge/Kconfig:30: unknown option "The"
arch/arm/mach-footbridge/Kconfig:31: unknown option "There"
arch/arm/mach-footbridge/Kconfig:32: unknown option "prototypes"
arch/arm/mach-footbridge/Kconfig:35: syntax error
arch/arm/mach-footbridge/Kconfig:34: unknown option "http"
arch/arm/mach-footbridge/Kconfig:37: syntax error
arch/arm/mach-footbridge/Kconfig:36: unknown option "If"
arch/arm/mach-footbridge/Kconfig:37: unknown option "Server"
arch/arm/mach-pxa/Kconfig:18: syntax error
arch/arm/mach-pxa/Kconfig:3: missing end statement for this entry
arch/arm/mach-pxa/Kconfig:3: missing end statement for this entry
arch/arm/Kconfig:245: missing end statement for this entry
arch/arm/mach-pxa/Kconfig:17: invalid statement
arch/arm/mach-pxa/Kconfig:632: unexpected end statement
arch/arm/mach-pxa/Kconfig:634: syntax error
arch/arm/mach-pxa/Kconfig:633: unexpected option "select"
arch/arm/mach-pxa/Kconfig:634: unexpected option "select"
arch/arm/mach-pxa/Kconfig:733: unexpected end statement
arch/arm/Kconfig:1416: unexpected end statement
make[3]: *** [nhk8815_defconfig] Error 1
make[2]: *** [nhk8815_defconfig] Error 2
make[1]: *** [sub-make] Error 2
make[1]: Leaving directory `/var/linus/linux'
make: *** [config-base] Error 2

Yours,
Linus Walleij
