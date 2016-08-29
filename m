From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Aug 2016 12:01:57 +0100
Subject: [PATCH 0/3] SA11x0 gpio keys/leds
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829100232.GC1041@n2100.armlinux.org.uk>
 <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <20160829110157.GE1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches:

* convert Assabet LEDs to use the gpiolib LED driver, now that we have
  the assabet board control register modelled as a gpiolib driver.
* adds gpiokeys support for the buttons connected to GPIO0/1, which
  are used to wake up the system after putting it to S2R sleep.  Without
  this, it's hard to test S2R.
* convert Cerf to ues the gpioleds registration API.

 arch/arm/mach-sa1100/Kconfig   |   2 +
 arch/arm/mach-sa1100/assabet.c | 139 ++++++++++++++++-------------------------
 arch/arm/mach-sa1100/cerf.c    |  11 +---
 3 files changed, 57 insertions(+), 95 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
