From: greg@kroah.com (Greg KH)
Date: Tue, 6 Oct 2009 14:57:48 -0700
Subject: Kernel update to 2.6.31.1 on pxa270: udev and usb storage
	cause kernel Oops
In-Reply-To: <1254822010.7077.17.camel@wks02-lin.nanotronic.local>
References: <1254213562.5586.13.camel@wks02-lin.nanotronic.local>
	<20091003124832.GA15525@n2100.arm.linux.org.uk>
	<20091005225222.GB792@kroah.com>
	<1254822010.7077.17.camel@wks02-lin.nanotronic.local>
Message-ID: <20091006215748.GA22303@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2009 at 11:40:10AM +0200, hoefle marco wrote:
> On Mon, 2009-10-05 at 15:52 -0700, Greg KH wrote:
> > On Sat, Oct 03, 2009 at 01:48:32PM +0100, Russell King - ARM Linux wrote:
> > > I think you need to report this to the USB/udev people.
> > > 
> > > On Tue, Sep 29, 2009 at 10:39:22AM +0200, hoefle marco wrote:
> > > > Hello,
> > > > we use Kernel 2.6.30.4 on a PXA270 platform (from Phytec). It works good
> > > > with all peripherals on the Phytec board. 
> > > > For an old Sandisk device (diskonchip) we have a driver ported to 2.6.3x
> > > > as the block device driver API has changed. We thought it will be a wise
> > > > decision to do the porting already to 2.6.3x. 
> > > > However, when using the latest Kernel (and the previous one 2.6.30) with
> > > > all the drivers we used in 2.6.30.4 udev and usb storage seem not to
> > > > work any more.
> > > > Does anybody have an idea why?
> > 
> > No, I don't. Do you have a pointer to your code anywhere?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hello Greg,
> I attached the patch and the .config for our pxa board. The largest part
> is the tffs driver, the board specific things are very little.

Ick, what is wrong with the existing disk-on-a-chip support we have in
Linux?

> This patch and the .config work for 2.6.30.4 except this tffs sandisk
> block device driver. Per default the driver is not compiled into the
> kernel so I think it is not affecting the behavior I am facing.
> 
> I tried now the latest stable kernel 2.6.31.2.
> After downloading the kernel I patched the kernel sources and used the
> attached .config for building the kernel.
> I get still the same errors and backtrace messages.
> Both times the kernel oops happens when the PC is in the strlen
> function.
> Any hints on how to debug this?

I do not know, sorry.  It's very strange.

good luck,

greg k-h
