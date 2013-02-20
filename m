From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Feb 2013 18:44:13 +0000
Subject: [PATCH 2/2] USB: EHCI: make ehci-orion a separate driver
In-Reply-To: <20130220182852.GA11327@kroah.com>
References: <1360966349-1242560-2-git-send-email-arnd@arndb.de>
 <20130219072438.GQ20212@lunn.ch> <20130220182852.GA11327@kroah.com>
Message-ID: <201302201844.13534.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 February 2013, Greg KH wrote:
> On Tue, Feb 19, 2013 at 08:24:38AM +0100, Andrew Lunn wrote:
> > 
> > GregKH: Please can you drop this patch from usb-next. It breaks more
> > than it fixes.
> 
> I've now reverted both of these, and the follow-on patch that Arnd sent
> in.
> 
> Arnd, sorry, but please be more careful, especially when you ask for
> patches to be rushed into the tree...

Yes, I understand. I'll try to come up with a less invasive way to
deal with the build error in 3.9 once the ARM multiplatform branch
gets pulled.

I guess we could either forbid the combinations that are now broken
using Kconfig dependencies, or add just add separate registriation
paths to ehci_hcd_init() and ehci_hcd_cleanup() as we have for
powerpc, although Alan did not like that too much last time I
suggested it.

	Arnd
