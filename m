From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 23 May 2013 16:50:59 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <201305231614.53664.arnd@arndb.de>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305222240.05124.arnd@arndb.de> <20130523142301.10dbeff9@skate>
 <201305231614.53664.arnd@arndb.de>
Message-ID: <20130523165059.473032d2@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Thu, 23 May 2013 16:14:53 +0200, Arnd Bergmann wrote:
> On Thursday 23 May 2013, Thomas Petazzoni wrote:
> > But that's not the case. Neither the old nor the new bootloaders are
> > changing the Device Tree in any way that allows us to know whether
> > registers are mapped at 0xd0 and 0xf1. Those bootloaders are
> > already in the field, and we have little control over that. Even if
> > we had control, what we would tell Marvell to implement in their
> > U-Boot, today?
> 
> We would tell Marvell that changing the base address was a horrible
> mistake and that they have to revert to 0xd0 in order to make sure
> the mistake does not spread any further and all users would update.

The longer we wait to switch from 0xd0 to 0xf1, the more complex and
painful the migration will be.

Honestly, from Marvell perspective, switching to 0xf1 and dropping
support for the old platforms is not a problem. I insisted quite a lot
to be given time to find a reasonable solution, that is entirely
self-contained in SoC-specific code, to provide a transition path for
people who are using old bootloaders.

I'm humbly asking you to be pragmatic on this one, and understand that
the goal is to have the kernel assumes it's being booted with registers
configured at 0xf1 and that all the rest is a temporary workaround.

> > The DT binding of the mbus driver is not complete, and therefore
> > the mechanism to specify the location of the internal registers is
> > going to change when we introduce the DT binding for the mbus
> > driver.
> 
> Right. It should not be hard to agree on the binding at least, but
> you are correct that we don't have that today and we shouldn't rush
> things here.

Agreed. We are currently working on this, but it will take some time to
get sorted out properly.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
