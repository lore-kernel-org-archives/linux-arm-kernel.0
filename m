From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Aug 2011 23:02:50 +0200
Subject: How to handle named resources with DT?
In-Reply-To: <877h6173wm.fsf@ti.com>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<201108251705.43168.arnd@arndb.de> <877h6173wm.fsf@ti.com>
Message-ID: <32081673.hbCQs4qpyo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 August 2011 11:16:25 Kevin Hilman wrote:
> Please clarify. 
> 
> What I hear Russell saying is a problem with the implementation of the
> _byname API.  
> 
> What I hear you sating is that since DT doesn't support this, we need to
> remove it's usage completely from platform_devices also.
> 
> These are two very different approaches.
> 
> Fixing the implementation as Russell suggested seems relatively easy,
> and conceptually similar to adding it to the DT.  Removing _byname all
> together seems like significant work just to avoid adding a feature to
> the DT core.

It's not at all about whether the Linux codein drivers/of supports this
or not, adding it would be trivial. The point is that it would be
*wrong* to add it because there already exists a way to identify every
resource in the device tree and we should not extend that interface
to have multiple ways to do the same thing just for convenience of
a few device drivers! One of the important advantages of using the
IEEE device tree bindings is that we can define device trees that
are to a large degree compatible with how AIX, Solaris, MacOS, FreeBSD
and probably many more (lesser known) operating systems probe
their systems.

Changing the resource interface in Linux to have two 'name' fields
would also be terribly confusing and is not a good interface, it would
just solve another problem (silly entries in /proc/iomem) that we don't
need to have in the first place when we do the obvious conversion
of the drivers to the IEEE standard way of doing this.

	Arnd
