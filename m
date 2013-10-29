From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 18:20:52 +0100
Subject: Build failure: shmobile drm driver references backlight symbols
In-Reply-To: <20131029100413.GA8857@n2100.arm.linux.org.uk>
References: <20131029100413.GA8857@n2100.arm.linux.org.uk>
Message-ID: <1773467.v8Jb5caonk@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tuesday 29 October 2013 10:04:13 Russell King - ARM Linux wrote:
> My build system picked up on this failure:
> 
> drivers/built-in.o: In function `shmob_drm_backlight_init':
> fmc-chardev.c:(.text+0x9f2d0): undefined reference to
> `backlight_device_register' drivers/built-in.o: In function
> `shmob_drm_backlight_exit':
> fmc-chardev.c:(.text+0x9f370): undefined reference to
> `backlight_device_unregister'
> 
> which is cuased by drivers/gpu/drm/shmobile/shmob_drm_backlight.c being
> built without the backlight dependency being enabled.  It looks like
> the backlight dependency is a hard requirement, so needs ot be added
> to the Kconfig entry for this driver in some way.

Thank you for the report. I'll send a fix.

-- 
Regards,

Laurent Pinchart
