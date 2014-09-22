From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Sep 2014 13:08:27 +0200
Subject: [RFC PATCH v3 6/7] arm: call iommu_init before
 of_platform_populate
In-Reply-To: <20140922093614.GK1470@ulmo>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <1410539695-29128-7-git-send-email-will.deacon@arm.com>
 <20140922093614.GK1470@ulmo>
Message-ID: <11868654.D6MinQlF2p@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 September 2014 11:36:15 Thierry Reding wrote:
> On Fri, Sep 12, 2014 at 05:34:54PM +0100, Will Deacon wrote:
> > We need to ensure that the IOMMUs in the system have a chance to perform
> > some basic initialisation before we start adding masters to them.
> > 
> > This patch adds a call to of_iommu_init before of_platform_populate.
> 
> Why can't you call it from of_platform_populate() directly? That way it
> would be usable for all architectures rather than just ARM. Eventually
> we're going to need the same thing for 64-bit ARM (and possibly others
> as well).

IIRC, of_platform_populate can be called multiple times, even recursively
be drivers that populate their own child devices.

	Arnd
