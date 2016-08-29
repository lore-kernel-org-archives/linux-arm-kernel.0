From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Aug 2016 13:05:31 +0100
Subject: [PATCH 0/6] SA11x0 serial updates
In-Reply-To: <20160829112540.GF1041@n2100.armlinux.org.uk>
References: <20160829100232.GC1041@n2100.armlinux.org.uk>
 <20160829102328.GA28796@n2100.armlinux.org.uk>
 <20160829110157.GE1041@n2100.armlinux.org.uk>
 <20160829112540.GF1041@n2100.armlinux.org.uk>
Message-ID: <20160829120531.GG1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series converts SA11x0 serial to make use of the mctrl helpers
where appropriate.  This allows us to remove several board-specific
callbacks.

As serial is critical for console output, we report but otherwise
ignore any error except probe deferral from mctrl initialisation.

Obviously, as this is part of a larger series (and has dependencies
on the previous series) this can not be applied to individual
subsystem maintainer trees.  Please ack.

 arch/arm/mach-sa1100/assabet.c  |  91 +++++++++++----------------------
 arch/arm/mach-sa1100/badge4.c   |   2 -
 arch/arm/mach-sa1100/h3xxx.c    |  64 ++++-------------------
 arch/arm/mach-sa1100/hackkit.c  |  48 ------------------
 arch/arm/mach-sa1100/neponset.c | 109 +++++++++++-----------------------------
 drivers/tty/serial/Kconfig      |   1 +
 drivers/tty/serial/sa1100.c     |  42 ++++++++++++++--
 7 files changed, 106 insertions(+), 251 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
