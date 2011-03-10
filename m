From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Mar 2011 17:11:59 +0100
Subject: [RFC PATCHv1 1/2] Export SoC info through sysfs
In-Reply-To: <20110310152011.GH22195@opensource.wolfsonmicro.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103101602.19241.arnd@arndb.de>
	<20110310152011.GH22195@opensource.wolfsonmicro.com>
Message-ID: <201103101711.59544.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 March 2011, Mark Brown wrote:
> On Thu, Mar 10, 2011 at 04:02:18PM +0100, Arnd Bergmann wrote:
> 
> > I can accept that it's reasonable to put all devices under
> > /sys/devices/platform/ that are on the same top-level AHB or APB bus,
> > although I also don't see a reason against making that bus a single
> > device.
> 
> You could, though the bus will just be a noop.  Typically it's more than
> one bus but software basically can't tell.

Yes. The main reason for representing such a bus in sysfs would be
to match the SOC's block diagram with the structure in the kernel.

The cost of an extra device is roughly zero, but structure generally
helps. Another advantage is that you can associate attributes and names
with the device, and simplify naming of the children without risking
name space conflicts.

	Arnd
