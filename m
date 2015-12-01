From: broonie@kernel.org (Mark Brown)
Date: Tue, 1 Dec 2015 13:16:39 +0000
Subject: [PATCH, RESEND] regulator: core: fix regulator_lock_supply
 regression
In-Reply-To: <3504080.aWaTxHbgxH@wuerfel>
References: <3504080.aWaTxHbgxH@wuerfel>
Message-ID: <20151201131639.GH1929@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 02:46:41PM +0100, Arnd Bergmann wrote:
> As noticed by Geert Uytterhoeven, my patch to avoid a harmless build warning
> in regulator_lock_supply() was total crap and introduced a real bug:

I'm going to drop both this and the commit it's fixing for now as this
is causing boot failures on several boards (none of which I have sadly)
in -next:

  http://kernelci.org/boot/all/job/broonie-regulator/kernel/v4.4-rc3-17-ga6498dba8869/

which were bisected by Tyler to this:

  http://hastebin.com/noluripepa.sm

I'm not seeing anything obvious in the code at the minute having looked
for several seconds, I'll have a proper look later today all being well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151201/9be2276e/attachment.sig>
