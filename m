From: pma@sysgo.com (Pavel Machek)
Date: Thu, 16 Jun 2011 14:06:29 +0200
Subject: [PATCH V2] mmc: Enable the ADMA on esdhc imx driver
In-Reply-To: <20110616120009.GA23579@pengutronix.de>
References: <20110615082223.GA28798@atrey.karlin.mff.cuni.cz>
	<20110616115133.GC31375@pma.sysgo.com>
	<20110616120009.GA23579@pengutronix.de>
Message-ID: <20110616120629.GD31375@pma.sysgo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2011-06-16 14:00:09, Wolfram Sang wrote:
> 
> > Unfortunately register differences are common. Is there better
> > approach than patching it in low level functions like this?
> 
> I am all ears for suggestions...

One way would be to move functions such as 

sdhci_activate_led()

to the low level driver, and introduce functions such as
write_host_control() -- with no corresponding read_host_control, so
that translation is easy to do...
								Pavel 
