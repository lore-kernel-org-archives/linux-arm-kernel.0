From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 26 Feb 2013 18:24:58 +0100
Subject: Build failed for mvebu in linux-next due to duplicate commit for RTC
Message-ID: <512CEFEA.4060301@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

when I tried to use the linux-next git tree (next-20130226), I
encountered this error during build:

ERROR (duplicate_node_names): Duplicate node name /soc/rtc at 10300

I found it was because 2 version of the same patch have been submitted
to linux-next,
git log v3.8..HEAD --grep=RTC  arch/arm/boot/dts/armada-370-xp.dtsi

commit 25fe89035eb81ea8be7ebb98eba18a8da744d3a2
Author: Gregory CLEMENT <gregory.clement@free-electrons.com>
Date:   Wed Feb 20 13:15:47 2013 +1100

    arm: mvebu: add RTC support for Armada 370 and Armada XP

    The Armada 370 and Armada XP Socs have the same controller that the one
    used in the orion platforms.  This patch updates the device tree for these
    SoCs.

    Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
    Acked-by: Andrew Lunn <andrew@lunn.ch>
    Cc: Russell King <linux@arm.linux.org.uk>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

commit f70a08ce13cdec674eae271a2e76554ff20bf5f3
Author: Gregory CLEMENT <gregory.clement@free-electrons.com>
Date:   Wed Dec 12 10:06:24 2012 +0100

    arm: mvebu: Add RTC support for Armada 370 and Armada XP

    The Armada 370 and Armada XP Socs have the same controller that the
    one used in the orion platforms. This patch updates the device tree
    for these SoCs.

    Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
    Acked-by: Andrew Lunn <andrew@lunn.ch>
    Tested-by: Florian Fainelli <florian@openwrt.org>
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Jason Cooper <jason@lakedaemon.net>

I think that the commit 25fe89 came through Andrew Morton and my
second version f70a08ce came through Jason Cooper and then arm-soc.

First, what I have to do to fix this? The best solution should be to
remove the commit 25fe890 as it is the less recent. How can we
proceed ?

Then I am sorry to not have figure out this before. I thought the
automatic email I received from Andrew Morton where due to Jason that
have been pushed the patch to Andrew Morton. I wasn't aware that
Andrew Morton took care of the RTC subsystem a well.

Regards,

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
