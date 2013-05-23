From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 May 2013 16:14:53 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130523142301.10dbeff9@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305222240.05124.arnd@arndb.de> <20130523142301.10dbeff9@skate>
Message-ID: <201305231614.53664.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 May 2013, Thomas Petazzoni wrote:
> But that's not the case. Neither the old nor the new bootloaders are
> changing the Device Tree in any way that allows us to know whether
> registers are mapped at 0xd0 and 0xf1. Those bootloaders are already in
> the field, and we have little control over that. Even if we had
> control, what we would tell Marvell to implement in their U-Boot,
> today?

We would tell Marvell that changing the base address was a horrible
mistake and that they have to revert to 0xd0 in order to make sure
the mistake does not spread any further and all users would update.

> The DT binding of the mbus driver is not complete, and therefore
> the mechanism to specify the location of the internal registers is
> going to change when we introduce the DT binding for the mbus driver.

Right. It should not be hard to agree on the binding at least, but
you are correct that we don't have that today and we shouldn't rush
things here.

	Arnd
