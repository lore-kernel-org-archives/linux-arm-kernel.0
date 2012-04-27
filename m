From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Apr 2012 15:24:12 -0600
Subject: Tegra board file deprecation schedule
Message-ID: <4F9B0E7C.1060408@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eventually, Tegra support will become device tree only in the mainline
kernel; arch/arm/mach-tegra/board* will be deleted.

I propose the following policy towards this goal: I'd like to maintain
the board files until the relevant device tree file has the same level
of functionality. Once that is achieved, and a Linus kernel is release
with full support for the board via device tree, the board files can be
deleted from the next kernel release.

Does anyone have any issues with this?

The device tree conversion status is:

Cardhu/Ventana:

None; already device tree only

Seaboard:

Kaen and Wario board variants are not explicitly supported via device
tree. However, the differences are almost entirely minor (at least as
far as the current features supported in board-seaboard*), so anyone
wishing to use those board variants could easily create their own device
tree files. I plan to ignore Kaen/Wario and delete board-seaboard* in
3.6 unless someone objects.

Harmony:

Missing support for TPS6586x regulator, and PCI-Express controller.
Thierry is working on this. I hope this support will be ready to be
merged for 3.6, and hence board-harmony* can be deleted in 3.7.

TrimSlice:

Missing RTC and Micro-SD slot support. I've sent patches for this, which
will be merged today.

Missing audio support. I sent patches for this today. I hope they'll be
merged for 3.5.

Missing PCI-Express support; status above.

I hope board-trimslice* can be deleted in 3.7.

Paz00/Toshiba AC100:

Missing rfkill button support. Defining a good binding for this might
prove challenging. Marc Dietrich started work on this a while back. I
pinged him to see if he intends to continue this work.

This is probably the long-pole for completely removing board files,
unless we ignore the rfkill feature and delete the board files anyway.
