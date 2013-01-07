From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 7 Jan 2013 09:23:40 -0800
Subject: [PATCH 3.9] Driver for 7-segment displays connected over GPIOs
In-Reply-To: <20130107180708.2ffc1540@skate>
References: <1357576928-29133-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130107164845.GA2911@kroah.com> <20130107180708.2ffc1540@skate>
Message-ID: <20130107172340.GA32401@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 06:07:08PM +0100, Thomas Petazzoni wrote:
> Dear Greg Kroah-Hartman,
> 
> On Mon, 7 Jan 2013 08:48:45 -0800, Greg Kroah-Hartman wrote:
> 
> > If you ever add/remove/modify sysfs files, you have to also do the same
> > for the Documentation/ABI/ files as well, please redo that in this patch
> > series.
> 
> Sure.
> 
> > But, the bigger question is, why is this a kernel driver at all?  Can't
> > you do this from userspace today without any new kernel code?
> 
> Indeed, it can be done from userspace since we're just controlling
> GPIOs. Having a kernel driver allows to describe this device in the
> Device Tree, like all other devices, and have it "magically" appear,
> with a convenient user-space interface.

Ok, that means you want to use the kernel-standard userspace interface
for displays, right?  If so, why not use it?  I thought we already
supported LCD displays already, isn't there an interface for it?  Don't
create random magic sysfs files without really thinking about it.

> Not having a kernel driver means that gazillions of applications
> re-invent the same piece of code over and over again, have to hardcode
> the GPIO numbers for a given piece of hardware, while the kernel
> abstract all of this very nicely.

That sounds like a wonderful use of a userspace library to do this
properly.  Much like libusb does, right?

I still think as this can be done in userspace, it probably should be.

thanks,

greg k-h
