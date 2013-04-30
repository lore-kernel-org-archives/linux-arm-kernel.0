From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Apr 2013 09:17:39 +0100
Subject: Latest build results - errors/warnings - lots of them
Message-ID: <20130430081739.GP14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Latest nightly build of 3.9+my for-next+arm-soc's for-next results in a
great load of new warnings and errors.  arch/arm/common/mcpm_head.S,
arch/arm/common/mcpm_platsmp.c, arch/arm/common/vlock.S are the biggest
source of errors.

OMAP stuff needs a serious look at too - much Kconfig madness there
caused by over-use of select, which then goes on to cause build errors
because it assumes some stuff is always enabled.

There's also warnings about of_device_id from include/linux/of_platform.h
via from arch/arm/kernel/setup.c which feature in all the non-OF builds
too which need addressing.

See todays http://www.arm.linux.org.uk/developer/build/ results for all
the details and configs.  Not pushing my tree until some of this stuff
gets fixed.
