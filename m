From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Dec 2011 22:22:05 +0100
Subject: realview compulsory enables CONFIG_ARM_PATCH_PHYS_VIRT on me
Message-ID: <CACRpkdZ8jpz7WTP3gpfcTykQZaCjQLN9PZCAS+UJOWrzZo1bjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nico,

now I'm lost, I discussed by boot problems on ARM PB1176
with Marc and after some investigation I found this strange thing on
the lastest rc:s since -rc1:

In arch/arm/Kconfig ARM_PATCH_PHYS_VIRT is forcibly
disabled like so:

depends on !ARCH_REALVIEW || !SPARSEMEM

However if I just configure it for the realview_defconfig:

mkdir foo
make -f Makefile ARCH=arm CROSS_COMPILE=arm-none-eabi-
KBUILD_OUTPUT=foo realview_defconfig

It strangely selects this anyway, because now foo/.config has:
CONFIG_ARM_PATCH_PHYS_VIRT=y

Kconfig is a djungle to me, but I simply cannot find out
what is setting this anyway. The problem is not there on
v3.1, it does not get selected.

Any hints?

Yours,
Linus Walleij
