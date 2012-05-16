From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 May 2012 12:00:59 +0000
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <EE71107DF0D1F24FA2D95041E64AB9E801A56AA0A462@IL-MB01.marvell.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515164438.22258885@skate>
 <EE71107DF0D1F24FA2D95041E64AB9E801A56AA0A462@IL-MB01.marvell.com>
Message-ID: <201205161200.59362.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 May 2012, Lior Amsalem wrote:

> > Again we're really open on the solution. Lior from Marvell can give all the
> > necessary input to explain how the SoC family is organized.
> 
> I'll try to arrange our SoCs (EBU):
> 
> Orion family:
>       Flavors:
>             5082, 5181, 5181L, 5281, 6183, ...
>       Core: ARMv5 compatible (Feroceon and Jolteon)
>       Process: 90nm
>       Directory: mach-orion5x
>  
> Kirkwood family:
>       Flavors:
>       6190, 6192, ...
>           Core: ARMv5 compatible (Gandalf)
>           Process: 65nm
>           Directory: mach-kirkwood
> 
>       6282 a.k.a Kirkwood 55, Armada 300
>       6283 a.k.a Kirkwood 55, Armada 310
>           Core: ARMv5 compatible (Gandalf)
>           Process: 55nm
>           Directory: not in mainline, future plan
> 
>       6710 a.k.a Kirkwood 40, Armada 370
>           Core: ARMv7 compatible (PJ4B)
>           Process: 40nm
>           Directory: new code
> 
> Discovery family:
>       Flavors:
>       78100/78200 a.k.a DiscoDuo
>           Core: ARMv5 compatible (Gandalf)
>           Process: 65nm
>           Directory: mach-mv78xx0
> 
>       78230/78260/78460 a.k.a DiscoSMP, Armada XP
>           Core: ARMv7 compatible (PJ4B)
>           Process: 40nm
>           Directory: new code
> 
> Avanta family: (a.k.a Kirkwood 2)
>       Flavors:
>       6560/60, 6530P, 6510
>           Core: ARMv5 compatible (Gandalf)
>           Process: 55nm
>           Directory: no code in mainline yet, future plan
> 
> Dove: (application processor)
>       Flavors:
>       ap510 a.k.a Armada 510
>           Core: ARMv7 compatible (PJ4)
>           Process: 65nm
>           Directory: mach-dove
> 
> plat-orion holds code shared between the SoCs.
> There are more SoCs called Armada which are developed in other business 
> units in Marvell (mmp, pxa) but I'm not that familier with it.
> 
> I hope it helps mapping the different SoCs.

Thanks for the list, very helpful!

So do you think it makes sense to put all of these into mach-orion?

Where does the Armada 1000/1500 (88DE3010/88DE3100) fit in here. Is it
related to the EBU family above or the PXA/MMP family, or is it something
entirely different?

Also, I've seen dove (Armada 510) being referred to as PXA510. Is that
also an official designation or just a mistake made by people who were
confused by the marketing names?

	Arnd
