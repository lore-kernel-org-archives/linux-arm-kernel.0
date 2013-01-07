From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 7 Jan 2013 18:07:08 +0100
Subject: [PATCH 3.9] Driver for 7-segment displays connected over GPIOs
In-Reply-To: <20130107164845.GA2911@kroah.com>
References: <1357576928-29133-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130107164845.GA2911@kroah.com>
Message-ID: <20130107180708.2ffc1540@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Greg Kroah-Hartman,

On Mon, 7 Jan 2013 08:48:45 -0800, Greg Kroah-Hartman wrote:

> If you ever add/remove/modify sysfs files, you have to also do the same
> for the Documentation/ABI/ files as well, please redo that in this patch
> series.

Sure.

> But, the bigger question is, why is this a kernel driver at all?  Can't
> you do this from userspace today without any new kernel code?

Indeed, it can be done from userspace since we're just controlling
GPIOs. Having a kernel driver allows to describe this device in the
Device Tree, like all other devices, and have it "magically" appear,
with a convenient user-space interface.

Not having a kernel driver means that gazillions of applications
re-invent the same piece of code over and over again, have to hardcode
the GPIO numbers for a given piece of hardware, while the kernel
abstract all of this very nicely.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
