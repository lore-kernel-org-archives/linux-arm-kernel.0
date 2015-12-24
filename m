From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Dec 2015 10:58:30 +0100
Subject: Running arm:versatile_defconfig with qemu in linux-next
In-Reply-To: <567B76E0.6050106@roeck-us.net>
References: <567B76E0.6050106@roeck-us.net>
Message-ID: <201512241058.30249.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 December 2015, Guenter Roeck wrote:
> Hi all,
> 
> various versatile and realview configurations fail to run for me with
> qemu (2.5) in linux-next. Some of those are qemu configurations
> I collected from various sources, so I guess I am on my own there.
> However, the following standard configurations no longer work.
> 
> arm:versatileab:versatile_defconfig
> arm:versatilepb:versatile_defconfig

Just to be sure to rule out the obvious: are you using the dtb files from
the kernel, or do you have your own?

> I can no longer get realview-eb-mpcore and realview-eb to work either,
> but, again, that is with a qemu specific configuration.

These are still based on board files, right? Do the normal defconfigs
work?

> I tried to bisect, but there have been too many related changes in the code
> for it to succeed; some of the bisect attempts don't even compile, others fail
> due to different problems. Is it known if versatile_defconfig in linux-next runs
> on a real system ? If so, any idea what it might take to get it to work again
> with qemu ?

Please start with the next/multiplatform branch in arm-soc, which has the
conversion to devicetree. Let's first see if that works by itself. I would
hope that all commits on that branch build, but something may have gone wrong.

	Arnd
