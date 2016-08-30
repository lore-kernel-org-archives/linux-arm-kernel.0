From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Aug 2016 11:59:50 +0100
Subject: [PATCH 0/8] SA11x0/PXA remainder & cleanups
In-Reply-To: <20160830105117.GM1041@n2100.armlinux.org.uk>
References: <20160829120531.GG1041@n2100.armlinux.org.uk>
 <E1beLKT-0001U1-HK@rmk-PC.armlinux.org.uk>
 <20160830105117.GM1041@n2100.armlinux.org.uk>
Message-ID: <20160830105950.GA15580@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This last part of the series is predominantly a set of cleanup patches
removing definitions and files that aren't required, and moving some
files out of public view.  The ucb1x00 patch could arguably have
been sent in the first set, something that I'll arrange for the next
iteration.

Further conversions are possible - eg, mainstone could have its platform
register converted to the gpio-reg code, and then pxaficp and other
drivers could be further adapted to use gpiolib.  However, that would
make this series even larger than it already is, and I'm already
concerned that it's very much on the big side.  Given that it already
takes a long time to post this series in a sane manner, I'd like to
prevent it growing any further.

The only reason PXA got touched is becaues of the PCMCIA changes which
needed lubbock's MISC write register to be accessible for the MAX1600
code.

 arch/arm/mach-pxa/include/mach/lubbock.h           |   4 -
 arch/arm/mach-pxa/lubbock.c                        |   3 +-
 arch/arm/mach-sa1100/cerf.c                        |   3 +-
 arch/arm/mach-sa1100/{include/mach => }/cerf.h     |   9 +-
 arch/arm/mach-sa1100/include/mach/SA-1101.h        | 925 ---------------------
 arch/arm/mach-sa1100/include/mach/hardware.h       |   4 -
 arch/arm/mach-sa1100/include/mach/neponset.h       |  30 -
 arch/arm/mach-sa1100/nanoengine.c                  |   2 +-
 .../mach-sa1100/{include/mach => }/nanoengine.h    |  11 -
 arch/arm/mach-sa1100/neponset.c                    |  14 +-
 arch/arm/mach-sa1100/pci-nanoengine.c              |   3 +-
 drivers/mfd/ucb1x00-core.c                         |   4 -
 12 files changed, 8 insertions(+), 1004 deletions(-)
 rename arch/arm/mach-sa1100/{include/mach => }/cerf.h (66%)
 delete mode 100644 arch/arm/mach-sa1100/include/mach/SA-1101.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/neponset.h
 rename arch/arm/mach-sa1100/{include/mach => }/nanoengine.h (69%)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
