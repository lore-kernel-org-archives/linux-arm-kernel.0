From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 25 Jul 2013 15:41:21 +0530
Subject: [PATCH 01/15] drivers: phy: add generic PHY framework
In-Reply-To: <20130725092957.GV9858@sirena.org.uk>
References: <Pine.LNX.4.44L0.1307231708020.1304-100000@iolanthe.rowland.org>
 <5977067.8rykRgjgre@flatron> <201307242032.03597.arnd@arndb.de>
 <20130725092957.GV9858@sirena.org.uk>
Message-ID: <51F0F9C9.2020500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 25 July 2013 02:59 PM, Mark Brown wrote:
> On Wed, Jul 24, 2013 at 08:32:03PM +0200, Arnd Bergmann wrote:
> 
>> Sorry for jumping in to the middle of the discussion, but why does a *new*
>> framework even bother defining an interface for board files?
> 
>> Can't we just drop any interfaces for platform data passing in the phy
>> framework and put the burden of adding those to anyone who actually needs
>> them? All the platforms we are concerned with here (exynos and omap,
>> plus new platforms) can be booted using DT anyway.
> 
> There's a bunch of non-DT architectures that are in active use (blackfin
> for example) and I'd really hope that this is useful for some of them.
> 
> The pushback here was about the fact that the subsystem was doing odd
> things with selecting device names which is odd in itself, I don't know
> if that had bled over into the DT bindings but it sounded like it
> might've done so.

Not really. device names was specifically used for non-dt boot case. For dt, it
uses the phandle mechanism which is pretty much used in all other subsystems.
Anyway I'm fixing Greg's comments and will posting a new version soon.

Thanks
Kishon
