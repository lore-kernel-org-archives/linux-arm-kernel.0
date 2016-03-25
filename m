From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Mar 2016 15:50:32 +0000
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <4319407.5A4b1VspuB@wuerfel>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <12540712.SXPhdxqg9f@wuerfel> <20160325103253.GA2566@sirena.org.uk>
 <4319407.5A4b1VspuB@wuerfel>
Message-ID: <20160325155032.GH2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2016 at 04:11:05PM +0100, Arnd Bergmann wrote:

> There is nothing magic in the binding if we just do the same thing
> the flash driver does, and describe the memory range that is associated
> with a chipselect.

Why are we even doing that though?  Like I say it just seems pointlessly
unhelpful for users.  Are we really saying that every single system has
to go through and manually modify their DT so that they can use this
entirely in SoC feature?  That doesn't seem like winning...

> > > Ok, so with the static mapping it could be done very easily, or
> > > we need a more complex solution for the dynamic mapping.

> > Part of what I personally don't understand is why this is complicated?

> I think we'd need to add another special case in the bus driver
> for it, which otherwise should be able to handle this in a generic
> way: if we just use the existing binding, the spi host driver can
> simply call devm_ioremap_resource() to see if there is a map
> for a given chipselect and otherwise fall back to the current
> mode.

Why does the binding have to be in the client device to do that?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160325/fcb4e741/attachment.sig>
