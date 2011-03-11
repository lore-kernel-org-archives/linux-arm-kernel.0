From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Mar 2011 23:13:15 +0100
Subject: [RFC PATCHv2 1/2] Export SoC info through sysfs
In-Reply-To: <20110311220333.GA30232@kroah.com>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103112242.43962.arnd@arndb.de>
	<20110311220333.GA30232@kroah.com>
Message-ID: <201103112313.16128.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2011 23:03:33 Greg KH wrote:
> On Fri, Mar 11, 2011 at 10:42:43PM +0100, Arnd Bergmann wrote:
> > On Friday 11 March 2011 20:33:30 Greg KH wrote:
> > > Make this a "real" device not /sys/socinfo please.  It can be a platform
> > > device that export the needed information, that way you can have
> > > multiple ones.
> > 
> > Note that the version 1 of this patch had a device, and I argued against
> > that patch on the basis that anything under /sys/devices/ should
> > reflect an actual part of the hardware, which socinfo by itself
> > does not.
> 
> Why is the overall SoC not a device?  cpus are (well, they will be in a
> few kernel versions in the future), so what makes the other bits somehow
> "special"?

The suggestion was to have a single disconnected device stuck 
in /sys/devices/system/socinfo, and only have it there to
contain device attributes that can be collected from random
places in the system, such hardcoded board specific data,
or read from registers that belong to another device.

A real device IMHO would be one that has specific hardware
properties, such as its own set of device registers or other
devices that are attached to it and that are represented
as children of this device.

	Arnd
