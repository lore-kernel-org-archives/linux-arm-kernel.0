From: greg@kroah.com (Greg KH)
Date: Fri, 11 Mar 2011 14:03:33 -0800
Subject: [RFC PATCHv2 1/2] Export SoC info through sysfs
In-Reply-To: <201103112242.43962.arnd@arndb.de>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<20110311175816.GC7291@besouro.research.nokia.com>
	<20110311193330.GA14204@kroah.com>
	<201103112242.43962.arnd@arndb.de>
Message-ID: <20110311220333.GA30232@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2011 at 10:42:43PM +0100, Arnd Bergmann wrote:
> On Friday 11 March 2011 20:33:30 Greg KH wrote:
> > Make this a "real" device not /sys/socinfo please.  It can be a platform
> > device that export the needed information, that way you can have
> > multiple ones.
> 
> Note that the version 1 of this patch had a device, and I argued against
> that patch on the basis that anything under /sys/devices/ should
> reflect an actual part of the hardware, which socinfo by itself
> does not.

Why is the overall SoC not a device?  cpus are (well, they will be in a
few kernel versions in the future), so what makes the other bits somehow
"special"?

> I believe the best way to represent this really is to have
> a device (platform or other, I don't care) that:
> 
> * represents the SOC in its entirety
> * has the subdevices that are part of the SOC as direct
>   or indirect children
> * can be identified easily as a SOC (through one of
>   its name, its place in the hierarchy or its bus_type)
> * has the standard device attributes proposed in Maxime's
>   patch.

That's fine, as it would be a real "struct device" :)

thanks,

greg k-h
