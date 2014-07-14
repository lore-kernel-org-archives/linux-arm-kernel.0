From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 14 Jul 2014 08:15:34 +0200
Subject: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <201407121422.02078.arnd@arndb.de>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <20140712093917.GD18601@arm.com>
 <CAF6AEGutHp+3f3iPA+jjaRkqq=5T_vytZ_ESoSqsQ4RHZ8F8yQ@mail.gmail.com>
 <201407121422.02078.arnd@arndb.de>
Message-ID: <20140714061532.GB2081@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 12, 2014 at 02:22:01PM +0200, Arnd Bergmann wrote:
> On Saturday 12 July 2014, Rob Clark wrote:
> > >> Was there actually a good reason for having the device link to the
> > >> iommu rather than the other way around?  How much would people hate it
> > >> if I just ignore the generic bindings and use something that works for
> > >> me instead.  I mean, it isn't exactly like there is going to be .dts
> > >> re-use across different SoC's..  and at least with current IOMMU API
> > >> some sort of of_get_named_iommu() API doesn't really make sense.
> > >
> > > The thing is, if you end up ignoring the generic binding then we have two
> > > IOMMUs using the same (ARM SMMU) binding and it begs the question as to
> > > which is the more generic! I know we're keen to get this merged, but merging
> > > something that people won't use and calling it generic doesn't seem ideal
> > > either. We do, however, desperately need a generic binding.
> > 
> > yeah, ignoring the generic binding is not my first choice.  I'd rather
> > have something that works well for everyone.  But I wasn't really sure
> > if the current proposal was arbitrary, or if there are some
> > conflicting requirements between different platforms.
> 
> The common case that needs to be simple is attaching one (master) device
> to an IOMMU using the shared global context for the purposes of implementing
> the dma-mapping API.
> 
> The way that Thierry's binding does that is the obvious solution to this,
> and it mirrors what we do in practically every other subsystem.

That wasn't really the intention, though. We shouldn't be designing
bindings to work well in one use-case or another. My motivation for
doing it this way was that I think it naturally models the flow of
master IDs. They originate within the masters and flow towards the
IOMMU device. In other words, they are a property of the masters so
quite literally should be described in the device tree nodes of the
masters.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/378e34f9/attachment.sig>
