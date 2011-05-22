From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sun, 22 May 2011 12:00:46 +0200
Subject: [PATCH 2/2] drivers/amba: probe via device tree
In-Reply-To: <20110521234725.GB17672@n2100.arm.linux.org.uk>
References: <1305829704-11774-1-git-send-email-robherring2@gmail.com>
	<BANLkTi=8vX1Cs_fzpQXZBuuDuLYLu1FGmg@mail.gmail.com>
	<20110521234725.GB17672@n2100.arm.linux.org.uk>
Message-ID: <201105221200.46810.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, May 22, 2011, Russell King - ARM Linux wrote:
> On Sat, May 21, 2011 at 11:42:34AM -0600, Grant Likely wrote:
> > Russell, it seems to me that the primary behaviour that amba_bus has
> > over platform_bus is the clock management, and secondarily
> > verification of the type of device by the device id.  Am I correct, or
> > am I missing something?
> 
> It matches by vendor/device ID just like PCI does, and does the bus
> clock management and power management in a really nice way, which I
> doubt platform devices will ever do.

Then we should use the AMBA bus where possible.  Also, if there are
AMBA devices that currently pretend to be platform devices, they should be
converted back to AMBA.

> The way this discussion is going, I'm going to suggest that we also
> convert PCI stuff to being platform devices too.  I don't see the
> point of PCI existing for all the same reasons being given in this
> thread.

I agree.

Thanks,
Rafael
