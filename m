From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 1 Aug 2012 11:48:36 +0800
Subject: [06/10,V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <20120731205300.GA25721@roeck-us.net>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
 <20120731205300.GA25721@roeck-us.net>
Message-ID: <20120801034834.GA1672@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 01:53:00PM -0700, Guenter Roeck wrote:
> > +	spi_master_put(host);
> > +	kfree(host);
> > +
> 
> Is the kfree() here and in the probe function really necessary ? 
> 
The following is how the kerneldoc of spi_alloc_master says.

 * The caller is responsible for assigning the bus number and initializing
 * the master's methods before calling spi_register_master(); and (after errors
 * adding the device) calling spi_master_put() and kfree() to prevent a memory
 * leak.

> Couple of reasons for asking: No other SPI master driver calls it in the remove
> function (unless I missed it), most drivers don't call it in the probe
> function error path, and if I call it in the remove function in a SPI master
> driver I am working on, and load/unload the module several times in a row, I get
> a nasty kernel crash.
> 
So sounds like either code or the kerneldoc needs patching?

Regards,
Shawn
