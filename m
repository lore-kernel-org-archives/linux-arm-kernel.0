From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Oct 2013 10:04:13 +0000
Subject: Build failure: shmobile drm driver references backlight symbols
Message-ID: <20131029100413.GA8857@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My build system picked up on this failure:

drivers/built-in.o: In function `shmob_drm_backlight_init':
fmc-chardev.c:(.text+0x9f2d0): undefined reference to `backlight_device_register'
drivers/built-in.o: In function `shmob_drm_backlight_exit':
fmc-chardev.c:(.text+0x9f370): undefined reference to `backlight_device_unregister'

which is cuased by drivers/gpu/drm/shmobile/shmob_drm_backlight.c being
built without the backlight dependency being enabled.  It looks like
the backlight dependency is a hard requirement, so needs ot be added
to the Kconfig entry for this driver in some way.
