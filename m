From: marco.hoefle@nanotronic.ch (hoefle marco)
Date: Thu, 15 Oct 2009 10:06:25 +0200
Subject: Kernel update to 2.6.31.1 on pxa270: udev and usb storage
	cause kernel Oops
In-Reply-To: <1254822010.7077.17.camel@wks02-lin.nanotronic.local>
References: <1254213562.5586.13.camel@wks02-lin.nanotronic.local>
	<20091003124832.GA15525@n2100.arm.linux.org.uk>
	<20091005225222.GB792@kroah.com>
	<1254822010.7077.17.camel@wks02-lin.nanotronic.local>
Message-ID: <1255593985.9028.9.camel@wks02-lin.nanotronic.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-10-06 at 11:40 +0200, hoefle marco wrote:
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

The failure was caused by:
static struct isp1760_platform_data isp1760_platform_data __initdata = {

__initdata causes a section mismatch and finally a kernel oops. So it
was driver related not as I thought an udev issue. Strange that this
behavior didn't show up in 2.6.30.4.

Cheers,
Marco 
