From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 15:42:41 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <201205091419.50736.arnd@arndb.de>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205091243.13206.arnd@arndb.de>
 <20120509141316.GS3955@opensource.wolfsonmicro.com>
 <201205091419.50736.arnd@arndb.de>
Message-ID: <20120509144241.GW3955@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 02:19:50PM +0000, Arnd Bergmann wrote:
> On Wednesday 09 May 2012, Mark Brown wrote:

> > It does result in the really odd situation that the number that gets
> > stored in the resource is the register number plus an offset.  If
> > anything I'd expect that the resources would be defined so you had to
> > add the parent base address with the child resource being the offset
> > within the parent resource.  Though to be honest the parent resource is
> > almost always going to be numbered from zero so it's not going to make
> > much difference most of the time.

> But that's not how any of the other resources work: AFAICT, each resource
> type makes up an address space with unique ranges assigned to each 
> sibling and sub-ranges inside of that for its children.

That's what I'd expect, but you're saying that the values in the child
resources are being stored as base+actual values (where base is some
random number) rather than either actual values or as offsets within the
base range either of which would seem less surprising.  Presumably you'd
also need to walk up the tree to subtract all the bases if there was
more than one resource.

Perhaps I'm just totally failing to understand what you're saying?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120509/70a9fd82/attachment.sig>
