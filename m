From: gregkh@suse.de (Greg KH)
Date: Fri, 16 Jul 2010 01:55:33 -0700
Subject: tq 2440
In-Reply-To: <20100715210936.GB6773@n2100.arm.linux.org.uk>
References: <AANLkTimyBHliUa62qmfja_ke6YTTysiVAtJcZfi8l2gG@mail.gmail.com>
	<AANLkTil8GE1OguyAfp3XgfJvEmH98yNrlvGAx684a-qL@mail.gmail.com>
	<20100715163526.GJ29322@n2100.arm.linux.org.uk>
	<20100715165141.GA21272@suse.de>
	<20100715171029.GK29322@n2100.arm.linux.org.uk>
	<20100715172218.GA22197@suse.de>
	<20100715173322.GL29322@n2100.arm.linux.org.uk>
	<20100715205153.GC24463@suse.de>
	<20100715210936.GB6773@n2100.arm.linux.org.uk>
Message-ID: <20100716085533.GB2419@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 10:09:36PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 15, 2010 at 01:51:53PM -0700, Greg KH wrote:
> > On Thu, Jul 15, 2010 at 06:33:22PM +0100, Russell King - ARM Linux wrote:
> > > Another way to avoid the other complaints is to remove
> > > the unregistration in platform_register_devices().
> > 
> > No, because you could have created a platform device with a call to
> > platform_device_alloc() and then called platform_device_register() and
> > then later, platform_device_unregister(), right?
> 
> No.  Sorry, platform_register_devices should've been platform_add_devices().
> Please look at that function.

Hm, it just calls platform_device_register(), so it's pretty hard to
determine that it's a static device from that function.

> It's used to register an array of static platform devices from architecture
> code, as I've said in this thread once already.

I can't think of an easy way to prevent these types of devices from
being removed, other than the existing warnings we have.  I'll mull it
over some more and see if I can come up with something in the future.

thanks,

greg k-h
