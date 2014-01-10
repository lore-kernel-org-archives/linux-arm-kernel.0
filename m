From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 11 Jan 2014 07:55:57 +0800
Subject: [PATCH] ata: sata_mv: setting PHY speed according to SControl
 speed
In-Reply-To: <20140110174412.GJ19878@titan.lakedaemon.net>
References: <1387800455-30629-1-git-send-email-simon.guinot@sequanux.org>
 <20131231121214.GB3985@htj.dyndns.org>
 <20131231170515.GG32537@lunn.ch>
 <EE71107DF0D1F24FA2D95041E64AB9E801C034BF2AD1@IL-MB01.marvell.com>
 <20140110174412.GJ19878@titan.lakedaemon.net>
Message-ID: <20140111075557.353478fa@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Fri, 10 Jan 2014 12:44:12 -0500, Jason Cooper wrote:

> Lior, thanks for the clarification.  Simon, care to respin this with a
> check for "marvell,armada-370-xp" root compatible string?  It should be
> safe to say that if there is no DT, don't write the register.

Why check a root compatible string? If we do this, then we will have to
change the SATA driver for each and every new Marvell SoC that has this
PHY speed control register (and these new SOCs will not use the
"marvell,armada-370-xp" root compatible string, since they are clearly
not Armada 370/XP).

Instead, we should introduce an additional compatible string for the
SATA driver itself.

> Alternatively, we could do as Lior suggests, and create a new sata
> compatible string.  But I think that is overkill.

No, this is the right thing to do, IMO.

> Also, I'm growing more leery creating compatible strings for IP blocks
> which are tied to the SoC revision.  If the IP block doesn't get issued
> it's own version number/codename, we should just use the root compatible
> strings to determine which SoC we are on.  I'll expand on this though as
> I get caught up with Gregory's series's. 

I really disagree. It means that whenever a new root compatible string
is created for a new SOC, we will have to edit gazillions of drivers.
It's not because two SOCs have the same SATA IP that they are globally
compatible, and can therefore share the same root compatible strings.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
