From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 29 Dec 2010 14:40:55 -0700
Subject: [PATCH 1/9] spi/pxa2xx: register driver properly
In-Reply-To: <20101229212635.GA31347@www.tglx.de>
References: <20101229081120.GN8172@angua.secretlab.ca>
	<349566.41372.qm@web180301.mail.gq1.yahoo.com>
	<20101229212635.GA31347@www.tglx.de>
Message-ID: <20101229214054.GB15198@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 29, 2010 at 10:26:35PM +0100, Sebastian Andrzej Siewior wrote:
> * David Brownell | 2010-12-29 09:00:36 [-0800]:
> 
> >I detect an effort to change the classic model for board initialization in Linux:  first set up
> >and register all system/platform devices on each
> >board then do the same for their drivers.  ("hardware first" ... "software second".
> 
> What are you suggesting? platform_driver_probe() does not work with
> hotpluged devices.

That assumption only holds for certain devices on certain boards.
platform_device_probe() is a machine specific optimization that I will
not hesitate to remove if it breaks the driver on other machines.

> I don't see a reason why it should be available to drivers. It is
> unlikely that platform devices are hotlpluged but not impossible.

More and more likely all the time though.  Many drivers use the model
of registering child platform_devices (for instance, multi function
devices).

g.
