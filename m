From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Jul 2010 18:53:41 +0200
Subject: [PATCH v2 5/5] colibri-pxa3xx: add touchscreen support
In-Reply-To: <201007091847.59787.pieterg@gmx.com>
References: <201007082249.59852.pieterg@gmx.com>
	<201007091814.25040.arnd@arndb.de>
	<201007091847.59787.pieterg@gmx.com>
Message-ID: <201007091853.41395.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 July 2010, pieterg wrote:
> >
> > But doesn't the code still create both devices in /sys/devices/platform
> > then? AFAICT, there is no runtime probing support to make sure you only
> > register the device that is there.
> 
> Yes, they both show up. But at least the do not conflict, and only the 
> detected device will register an input device.

That's still putting the logic into the wrong place. If you have a way
to detect the hardware, that should be done before creating the device,
otherwise there is no point in having a platform device to start with
and you could just detect it in your module_init function.

	Arnd
