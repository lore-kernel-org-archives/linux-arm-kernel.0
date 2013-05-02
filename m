From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 May 2013 19:39:48 +0200
Subject: [PATCH 1/7] ARM: u300: push down syscon registers
In-Reply-To: <CACRpkdayJCm-PcY_=+NDraEPn0m6BrjNRH+tYp3Abar43RamaA@mail.gmail.com>
References: <1367511416-4312-1-git-send-email-linus.walleij@stericsson.com>
 <201305021821.12008.arnd@arndb.de>
 <CACRpkdayJCm-PcY_=+NDraEPn0m6BrjNRH+tYp3Abar43RamaA@mail.gmail.com>
Message-ID: <201305021939.48381.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013, Linus Walleij wrote:
> > How do those drivers get to the SYSCON base address? Should they
> > be using drivers/mfd/syscon.c as the multiplexor instead?
> 
> No, there is no mutex to be taken. The consecutive range of memory
> addresses are used by different things (mainly the clocks) but there
> is no register that needs to be protected against access from two
> subsystems simultaneously.
> 
> As a follow-up to this series I plan to move also the U300 clocks
> to the device tree (similar three-step ladder as used for the Nomadik)
> and then they will (hopefully) get the syscon base address from the
> device tree.

I was less worried about mutexes than a correct representation
in the device tree. With the syscon driver, you can have the
register ranges described exactly once and just use the offsets
on the regmap in the other drivers.

	Arnd
