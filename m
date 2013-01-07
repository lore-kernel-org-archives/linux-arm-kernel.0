From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 7 Jan 2013 18:40:22 +0100
Subject: [PATCH 3.9] Driver for 7-segment displays connected over GPIOs
In-Reply-To: <20130107172340.GA32401@kroah.com>
References: <1357576928-29133-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130107164845.GA2911@kroah.com> <20130107180708.2ffc1540@skate>
 <20130107172340.GA32401@kroah.com>
Message-ID: <20130107184022.72b23aa9@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Greg Kroah-Hartman,

On Mon, 7 Jan 2013 09:23:40 -0800, Greg Kroah-Hartman wrote:

> > Indeed, it can be done from userspace since we're just controlling
> > GPIOs. Having a kernel driver allows to describe this device in the
> > Device Tree, like all other devices, and have it "magically" appear,
> > with a convenient user-space interface.
> 
> Ok, that means you want to use the kernel-standard userspace interface
> for displays, right?  If so, why not use it?  I thought we already
> supported LCD displays already, isn't there an interface for it?  Don't
> create random magic sysfs files without really thinking about it.

Well, the LCD interface is about outputting pixel into a video memory.
Quite different from:

echo 6 > /sys/[...]/gpio-7seg.1/value

No?

> > Not having a kernel driver means that gazillions of applications
> > re-invent the same piece of code over and over again, have to hardcode
> > the GPIO numbers for a given piece of hardware, while the kernel
> > abstract all of this very nicely.
> 
> That sounds like a wonderful use of a userspace library to do this
> properly.  Much like libusb does, right?
> 
> I still think as this can be done in userspace, it probably should be.

Understood. Patches discarded.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
