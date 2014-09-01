From: will.deacon@arm.com (Will Deacon)
Date: Mon, 1 Sep 2014 17:36:12 +0100
Subject: [RFC PATCH 1/7] iommu: provide early initialisation hook for
 IOMMU drivers
In-Reply-To: <4386980.goxm0OjCmJ@wuerfel>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
 <1409327670-3495-2-git-send-email-will.deacon@arm.com>
 <20140901075216.GA24430@ulmo> <4386980.goxm0OjCmJ@wuerfel>
Message-ID: <20140901163612.GL24594@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 03:31:28PM +0100, Arnd Bergmann wrote:
> On Monday 01 September 2014 09:52:19 Thierry Reding wrote:
> > I don't think this is the right direction. We've been preaching that
> > using initcall ordering is a bad thing and people should be using
> > deferred probe instead. Now we have a bunch of these OF tables that do
> > the exact opposite. Note that these are nothing more than a variant of
> > initcalls that get called at platform-specific points in time.
> > 
> > There are also ongoing discussions about how to change the device probe
> > order to use dependencies (such as phandles from device tree) to prevent
> > excessive deferred probing. With that in place this would be solved in a
> > much more generic way.
> 
> We are not creating an ABI here, so it can always be changed later.
> For now, I think iommus are clearly in the same category as irqchips,
> timers, clock controllers and smp operations: we really want them
> to be available before we set up any other devices.

I'm also trying to move the SMMU driver to the generic bindings before the
existing bindings start getting used. The sooner we have parsing of the
generic binding in the core code, the sooner that can happen.

Will
