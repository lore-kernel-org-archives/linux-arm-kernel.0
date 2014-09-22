From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 22 Sep 2014 13:40:40 +0200
Subject: [RFC PATCH v3 6/7] arm: call iommu_init before
 of_platform_populate
In-Reply-To: <11868654.D6MinQlF2p@wuerfel>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <1410539695-29128-7-git-send-email-will.deacon@arm.com>
 <20140922093614.GK1470@ulmo> <11868654.D6MinQlF2p@wuerfel>
Message-ID: <20140922114039.GT1470@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 01:08:27PM +0200, Arnd Bergmann wrote:
> On Monday 22 September 2014 11:36:15 Thierry Reding wrote:
> > On Fri, Sep 12, 2014 at 05:34:54PM +0100, Will Deacon wrote:
> > > We need to ensure that the IOMMUs in the system have a chance to perform
> > > some basic initialisation before we start adding masters to them.
> > > 
> > > This patch adds a call to of_iommu_init before of_platform_populate.
> > 
> > Why can't you call it from of_platform_populate() directly? That way it
> > would be usable for all architectures rather than just ARM. Eventually
> > we're going to need the same thing for 64-bit ARM (and possibly others
> > as well).
> 
> IIRC, of_platform_populate can be called multiple times, even recursively
> be drivers that populate their own child devices.

Indeed. Perhaps it could be conditionally called when root == NULL. But
perhaps that's not safe either. Anyway, I still think we shouldn't be
making this some randomly placed early initcall anyway.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140922/ce0536c5/attachment.sig>
