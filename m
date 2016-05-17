From: bluekvirus@gmail.com (Zhiyuan Liu)
Date: Tue, 17 May 2016 12:41:11 -0700
Subject: Regarding auto reset 4B back to 3B for spi-flash before reboot.
Message-ID: <CANN9mDGhp++hHV_XituWwdCXr+7kjUenekKyBm89xX9i9O43Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Guys,

I'm working on an embedded arm project for gateways and stuff, my
board has an spi-flash which utilizes

mtd/devices/m25p80.c

and it needs to reset with the exit 4B cmd before rebooting or else
the bootrom on marvell 6820 dev board won't find it again without a
hard reset (power cycling).

Currently I have added a .shutdown to issue flash cmd directly to the
chip for that but, I was just wondering if there is a better way of
doing it? My goal is to just change the devicetree not the kernel
drivers.

Have you already designed a way of doing it that I'm not aware of? Or
simply because the majority of the vendor flash chips don't need it?

Again, I'm not planning to suggest any changes accordingly, just
trying to learn from the better minds.

Many thanks,
Tim.
