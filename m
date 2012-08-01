From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 31 Jul 2012 22:42:28 -0700
Subject: [06/10,V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <20120801055854.GE1672@S2100-06.ap.freescale.net>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
 <20120801033559.GB2323@roeck-us.net>
 <20120801045010.GC1672@S2100-06.ap.freescale.net>
 <201208010700.54829.marex@denx.de>
 <20120801052947.GA2400@roeck-us.net>
 <20120801055854.GE1672@S2100-06.ap.freescale.net>
Message-ID: <20120801054228.GA2645@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2012 at 01:58:56PM +0800, Shawn Guo wrote:
> On Tue, Jul 31, 2012 at 10:29:47PM -0700, Guenter Roeck wrote:
> > Anyone up for writing some patches ? If not, I'll do it.
> > 
> Go ahead.
> 
Ok, will do. It isn't that simple, actually, since at least some of the drivers
also call spi_master_get(), and thus need two calls to spi_master_put() (or a
call to spi_master_put and a call to kfree).

Guenter
