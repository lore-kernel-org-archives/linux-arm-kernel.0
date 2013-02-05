From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Feb 2013 16:27:18 +0000
Subject: [PATCH 12/15] USB: gadget/freescale: disable non-multiplatform
 drivers
In-Reply-To: <20130121185716.GA26754@kroah.com>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <20130121184138.GB10106@arwen.pp.htv.fi> <20130121185716.GA26754@kroah.com>
Message-ID: <201302051627.18337.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 January 2013, Greg Kroah-Hartman wrote:
> On Mon, Jan 21, 2013 at 08:41:38PM +0200, Felipe Balbi wrote:
> > Hi,
> > 
> > On Mon, Jan 21, 2013 at 05:16:05PM +0000, Arnd Bergmann wrote:
> > > Both the fsl_mxc gadget and the imx_udc gadget drivers fail to build
> > > without the mach/hardware.h file that is not available when building
> > > for multiplatform. Let's disable these drivers for v3.8 in combination
> > > with CONFIG_ARCH_MULTIPLATFORM, and fix them properly in v3.9 unless
> > > someone has an better solution.
> > > 
> > > Without this patch, building allyesconfig results in:
> > > 
> > > drivers/usb/gadget/fsl_mxc_udc.c:21:27: fatal error: mach/hardware.h: No such file or directory
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Felipe Balbi <balbi@ti.com>
> > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: linux-usb at vger.kernel.org
> > 
> > NAK, I prefer to see a real fix for the problem (which in fact is
> > already in my fixes branch).
> 
> I'll pull that branch now, sorry for the delay.

Apparently it hasn't made it into the upstream kernel yet, and it also doesn't
seem to be in linux-next. Maybe this got lost while you were travelling?

	Arnd
