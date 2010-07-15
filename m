From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jul 2010 22:09:36 +0100
Subject: tq 2440
In-Reply-To: <20100715205153.GC24463@suse.de>
References: <AANLkTimyBHliUa62qmfja_ke6YTTysiVAtJcZfi8l2gG@mail.gmail.com>
	<AANLkTil8GE1OguyAfp3XgfJvEmH98yNrlvGAx684a-qL@mail.gmail.com>
	<20100715163526.GJ29322@n2100.arm.linux.org.uk>
	<20100715165141.GA21272@suse.de>
	<20100715171029.GK29322@n2100.arm.linux.org.uk>
	<20100715172218.GA22197@suse.de>
	<20100715173322.GL29322@n2100.arm.linux.org.uk>
	<20100715205153.GC24463@suse.de>
Message-ID: <20100715210936.GB6773@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 01:51:53PM -0700, Greg KH wrote:
> On Thu, Jul 15, 2010 at 06:33:22PM +0100, Russell King - ARM Linux wrote:
> > Another way to avoid the other complaints is to remove
> > the unregistration in platform_register_devices().
> 
> No, because you could have created a platform device with a call to
> platform_device_alloc() and then called platform_device_register() and
> then later, platform_device_unregister(), right?

No.  Sorry, platform_register_devices should've been platform_add_devices().
Please look at that function.

It's used to register an array of static platform devices from architecture
code, as I've said in this thread once already.
