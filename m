From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 16 Jun 2011 14:19:42 +0200
Subject: [PATCH V2] mmc: Enable the ADMA on esdhc imx driver
In-Reply-To: <20110616120629.GD31375@pma.sysgo.com>
References: <20110615082223.GA28798@atrey.karlin.mff.cuni.cz>
	<20110616115133.GC31375@pma.sysgo.com>
	<20110616120009.GA23579@pengutronix.de>
	<20110616120629.GD31375@pma.sysgo.com>
Message-ID: <20110616121942.GD23579@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2011 at 02:06:29PM +0200, Pavel Machek wrote:
> On Thu 2011-06-16 14:00:09, Wolfram Sang wrote:
> > 
> > > Unfortunately register differences are common. Is there better
> > > approach than patching it in low level functions like this?
> > 
> > I am all ears for suggestions...
> 
> One way would be to move functions such as 
> 
> sdhci_activate_led()
> 
> to the low level driver,

There is no "low level driver" if the controller is done right.

> and introduce functions such as write_host_control() -- with no
> corresponding read_host_control, so that translation is easy to do...

So, a seperate function for every register which differs from the
standard? There are a lot of SoCs out there, and even more to come...

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110616/09c3d3da/attachment.sig>
