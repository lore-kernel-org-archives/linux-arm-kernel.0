From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Mar 2011 16:02:18 +0100
Subject: [RFC PATCHv1 1/2] Export SoC info through sysfs
In-Reply-To: <20110310144455.GG22195@opensource.wolfsonmicro.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103101529.25661.arnd@arndb.de>
	<20110310144455.GG22195@opensource.wolfsonmicro.com>
Message-ID: <201103101602.19241.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 March 2011, Mark Brown wrote:
> Most of the devices doing that on ARMs tend to be devices where there's
> no bus that it's meaningful to expose to software - they'll typically be
> hanging off an AHB or APB bus which has either no real software control
> or control which is very heavily tied into the overall system control
> and so is better treated over the whole SoC rather than the bus.

I can accept that it's reasonable to put all devices under
/sys/devices/platform/ that are on the same top-level AHB or APB bus,
although I also don't see a reason against making that bus a single
device.

The one thing that really doesn't belong in /sys/devices/platform/
however are devices that are clearly children of some other
device, e.g. a UART behind MFD behind I2C behind AHB.

	Arnd
