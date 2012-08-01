From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 1 Aug 2012 16:20:26 +0800
Subject: [06/10,V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <20504.56543.699097.320114@ipc1.ka-ro>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
 <201208010810.37652.marex@denx.de>
 <20120801063936.GC2764@roeck-us.net>
 <201208010845.19361.marex@denx.de>
 <20120801074051.GG1672@S2100-06.ap.freescale.net>
 <20504.56543.699097.320114@ipc1.ka-ro>
Message-ID: <20120801082024.GJ1672@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2012 at 09:38:07AM +0200, Lothar Wa?mann wrote:
> Shawn Guo writes:
> > On Wed, Aug 01, 2012 at 08:45:19AM +0200, Marek Vasut wrote:
> > > > I must be missing something.  Why do almost all spi drivers call it in the
> > > > error path, even if there is no call to spi_master_get ?
> > > 
> > > To push the refcounting to 0, to deallocate the device, I'd say ...
> > > 
> > It's not going to work if spi_master_put is called without
> > spi_master_get being called before that.
> > 
> spi_alloc_master() calls device_initialize() which resuires a
> device_put() (called from spi_master_put()) to free the device.
> 
Ah, indeed.  I missed that kref_init() will initialize the refcount
to 1.

Thanks,
Shawn
