From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 Mar 2011 15:20:11 +0000
Subject: [RFC PATCHv1 1/2] Export SoC info through sysfs
In-Reply-To: <201103101602.19241.arnd@arndb.de>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103101529.25661.arnd@arndb.de>
	<20110310144455.GG22195@opensource.wolfsonmicro.com>
	<201103101602.19241.arnd@arndb.de>
Message-ID: <20110310152011.GH22195@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 04:02:18PM +0100, Arnd Bergmann wrote:

> I can accept that it's reasonable to put all devices under
> /sys/devices/platform/ that are on the same top-level AHB or APB bus,
> although I also don't see a reason against making that bus a single
> device.

You could, though the bus will just be a noop.  Typically it's more than
one bus but software basically can't tell.

> The one thing that really doesn't belong in /sys/devices/platform/
> however are devices that are clearly children of some other
> device, e.g. a UART behind MFD behind I2C behind AHB.

Right, and we seem to be fairly good at squashing such bugs when people
notice them.
