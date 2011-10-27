From: vapier@gentoo.org (Mike Frysinger)
Date: Thu, 27 Oct 2011 17:38:22 +0200
Subject: acs5k_tiny_defconfig broken by mach-ks8695 GPIO move
Message-ID: <CAJaTeTqTE=yGk7p7m-vb3S3pR9k7vEWXAXQFBGHEWVY_2NPyvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this commit:
commit db23c7332b5391646c32585b06328da0463418f8
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Mon Aug 22 08:37:10 2011 +0100
ARM: 7035/1: mach-ks8695: move GPIO driver to GPIO subsystem

breaks acs5k_tiny_defconfig:
arch/arm/mach-ks8695/built-in.o: In function `acs5k_init':
board-acs5k.c:(.init.text+0x230): undefined reference to `ks8695_register_gpios'
make: *** [.tmp_vmlinux1] Error 1
-mike
