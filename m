From: greg@kroah.com (Greg KH)
Date: Tue, 14 Dec 2010 09:06:56 -0800
Subject: [PATCH v3 0/4] Introduce hardware spinlock framework
In-Reply-To: <AANLkTin1fd=Kei7Fo6G+uR+270HdTkc71fvsA6qjBjcA@mail.gmail.com>
References: <1291420247-18171-1-git-send-email-ohad@wizery.com>
	<AANLkTin1fd=Kei7Fo6G+uR+270HdTkc71fvsA6qjBjcA@mail.gmail.com>
Message-ID: <20101214170656.GA3832@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 14, 2010 at 04:31:36PM +0200, Ohad Ben-Cohen wrote:
> Hi Greg, Tony,
> 
> On Sat, Dec 4, 2010 at 1:50 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > OMAP4 introduces a Hardware Spinlock device, which provides hardware
> > assistance for synchronization and mutual exclusion between heterogeneous
> > processors and those not operating under a single, shared operating system
> > (e.g. OMAP4 has dual Cortex-A9, dual Cortex-M3 and a C64x+ DSP).
> >
> > The intention of this hardware device is to allow remote processors,
> > that have no alternative mechanism to accomplish synchronization and mutual
> > exclusion operations, to share resources (such as memory and/or any other
> > hardware resource).
> >
> > This patchset adds hwspinlock framework that makes it possible
> > for drivers to use those hwspinlock devices and stay platform-independent.
> 
> ...
> 
> > ?Documentation/hwspinlock.txt ? ? ? ? ? ? ? | ?299 +++++++++++++++
> > ?arch/arm/mach-omap2/Makefile ? ? ? ? ? ? ? | ? ?1 +
> > ?arch/arm/mach-omap2/hwspinlock.c ? ? ? ? ? | ? 63 ++++
> > ?arch/arm/mach-omap2/omap_hwmod_44xx_data.c | ? 64 ++++
> > ?drivers/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?2 +
> > ?drivers/Makefile ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ?1 +
> > ?drivers/hwspinlock/Kconfig ? ? ? ? ? ? ? ? | ? 22 ++
> > ?drivers/hwspinlock/Makefile ? ? ? ? ? ? ? ?| ? ?6 +
> > ?drivers/hwspinlock/hwspinlock.h ? ? ? ? ? ?| ? 61 +++
> > ?drivers/hwspinlock/hwspinlock_core.c ? ? ? | ?557 ++++++++++++++++++++++++++++
> > ?drivers/hwspinlock/omap_hwspinlock.c ? ? ? | ?231 ++++++++++++
> > ?include/linux/hwspinlock.h ? ? ? ? ? ? ? ? | ?298 +++++++++++++++
> > ?12 files changed, 1605 insertions(+), 0 deletions(-)
> 
> Can you please have a look and say if this looks OK ?

Look at what, I don't see a patch here.

I've seen a lot of discussion about this, are all of the review comments
now addressed?  Like the most important one, why is this generic code if
it's only for one specific platform?

thanks,

greg k-h
