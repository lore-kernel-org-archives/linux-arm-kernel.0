From: pieterg@gmx.com (pieterg)
Date: Fri, 9 Jul 2010 19:21:31 +0200
Subject: [PATCH v2 5/5] colibri-pxa3xx: add touchscreen support
In-Reply-To: <201007091853.41395.arnd@arndb.de>
References: <201007082249.59852.pieterg@gmx.com>
	<201007091847.59787.pieterg@gmx.com>
	<201007091853.41395.arnd@arndb.de>
Message-ID: <201007091921.32323.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 July 2010 18:53:41 Arnd Bergmann wrote:
> On Friday 09 July 2010, pieterg wrote:
> > > But doesn't the code still create both devices in
> > > /sys/devices/platform then? AFAICT, there is no runtime probing
> > > support to make sure you only register the device that is there.
> >
> > Yes, they both show up. But at least the do not conflict, and only the
> > detected device will register an input device.
>
> That's still putting the logic into the wrong place. If you have a way
> to detect the hardware, that should be done before creating the device,
> otherwise there is no point in having a platform device to start with
> and you could just detect it in your module_init function.

Note that this would not happen normally.
The concern was raised as to what would happen if the user accidentally put 
two different AC97/touchscreen controllers in the kernelconfig, while there 
is only one AC97 interface.
And my observation is that nothing serious happens in that case.
