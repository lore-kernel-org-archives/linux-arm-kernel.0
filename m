From: broonie@kernel.org (Mark Brown)
Date: Thu, 25 Jul 2013 10:29:57 +0100
Subject: [PATCH 01/15] drivers: phy: add generic PHY framework
In-Reply-To: <201307242032.03597.arnd@arndb.de>
References: <Pine.LNX.4.44L0.1307231708020.1304-100000@iolanthe.rowland.org>
 <5977067.8rykRgjgre@flatron> <201307242032.03597.arnd@arndb.de>
Message-ID: <20130725092957.GV9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 08:32:03PM +0200, Arnd Bergmann wrote:

> Sorry for jumping in to the middle of the discussion, but why does a *new*
> framework even bother defining an interface for board files?

> Can't we just drop any interfaces for platform data passing in the phy
> framework and put the burden of adding those to anyone who actually needs
> them? All the platforms we are concerned with here (exynos and omap,
> plus new platforms) can be booted using DT anyway.

There's a bunch of non-DT architectures that are in active use (blackfin
for example) and I'd really hope that this is useful for some of them.

The pushback here was about the fact that the subsystem was doing odd
things with selecting device names which is odd in itself, I don't know
if that had bled over into the DT bindings but it sounded like it
might've done so.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130725/51a7cbff/attachment.sig>
