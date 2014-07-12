From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Jul 2014 14:22:01 +0200
Subject: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <CAF6AEGutHp+3f3iPA+jjaRkqq=5T_vytZ_ESoSqsQ4RHZ8F8yQ@mail.gmail.com>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <20140712093917.GD18601@arm.com>
 <CAF6AEGutHp+3f3iPA+jjaRkqq=5T_vytZ_ESoSqsQ4RHZ8F8yQ@mail.gmail.com>
Message-ID: <201407121422.02078.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 July 2014, Rob Clark wrote:
> >> Was there actually a good reason for having the device link to the
> >> iommu rather than the other way around?  How much would people hate it
> >> if I just ignore the generic bindings and use something that works for
> >> me instead.  I mean, it isn't exactly like there is going to be .dts
> >> re-use across different SoC's..  and at least with current IOMMU API
> >> some sort of of_get_named_iommu() API doesn't really make sense.
> >
> > The thing is, if you end up ignoring the generic binding then we have two
> > IOMMUs using the same (ARM SMMU) binding and it begs the question as to
> > which is the more generic! I know we're keen to get this merged, but merging
> > something that people won't use and calling it generic doesn't seem ideal
> > either. We do, however, desperately need a generic binding.
> 
> yeah, ignoring the generic binding is not my first choice.  I'd rather
> have something that works well for everyone.  But I wasn't really sure
> if the current proposal was arbitrary, or if there are some
> conflicting requirements between different platforms.

The common case that needs to be simple is attaching one (master) device
to an IOMMU using the shared global context for the purposes of implementing
the dma-mapping API.

The way that Thierry's binding does that is the obvious solution to this,
and it mirrors what we do in practically every other subsystem. I definitely
want the SMMU to change before anybody starts using it in a real system,
which we fortunately do not have yet.

	Arnd
