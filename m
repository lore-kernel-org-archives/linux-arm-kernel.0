From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Feb 2013 16:47:38 -0700
Subject: Multi-platform, and secure-only ARM errata workarounds
Message-ID: <512BF81A.3080700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

I'm looking into enabling CONFIG_MULTIPLATFORM on Tegra for 3.10, and
the main blocking issue is due to commit 62e4d35 "ARM: 7609/1: disable
errata work-arounds which access secure registers". Various Tegra
versions need 3 of those workarounds, and our bootloader doesn't
implement them (at the least, upstream U-Boot; not sure about our
downstream code, but I'm fairly sure given the lack of any feedback I
got in the bug I filed to implement them).

Now, I can easily add those 3 errata workarounds to U-Boot, but that
will require people to reflash their bootloader. This is probably
acceptable for development/reference boards (although I'm sure people
will find it annoying) but for re-purposed production boards (such as
the Toshiba AC100 or various tablets) it will be impossible to update
the factory bootloader. Switching to upstream U-Boot would currently
lose some functionality, and significantly affect people's boot flow, so
is likely unacceptable.

Is there any other alternative I'm not seeing? Having the kernel
suddenly become incompatible with any currently extant bootloader when I
enable CONFIG_MULTIPLATFORM doesn't seem like a great idea.
