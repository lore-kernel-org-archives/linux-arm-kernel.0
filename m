From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Feb 2011 11:07:17 +0100
Subject: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <20110212172357.GB9821@S2100-06.ap.freescale.net>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
	<201102120959.22707.arnd@arndb.de>
	<20110212172357.GB9821@S2100-06.ap.freescale.net>
Message-ID: <201102121107.17779.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 February 2011 18:23:58 Shawn Guo wrote:
> Well, we are removing inclusion of mach/dma.h from mmc driver, but
> adding it to every mxs based machine code.  This makes mmc driver
> clean but machine code becomes not.  For some dma client devices
> coming later, the platform data could be saved at all, if they do not
> have any.  But with the approach you are suggesting, every single
> client device will have to get platform data.

Right, unless there is a way to encode it exlusively in the resources,
which is what I was suggesting at first: If the dma engine driver
knows about all the channels, you only need to pass the channel number.

If you use a flattened device tree, you can avoid the need for
platform data by adding the phandle of the dma engine device to
a property of the mmc driver, along with the channel number inside
of that device. I think that would be the cleanest approach, but
some people still need to be convinced that changing drivers to
use fdt data is the right direction for ARM.

	Arnd
