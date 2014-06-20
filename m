From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Jun 2014 17:53:08 +0200
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140618101439.GF32699@arm.com>
References: <1400877395-4235-1-git-send-email-thierry.reding@gmail.com>
 <20140617233714.GD25525@mithrandir> <20140618101439.GF32699@arm.com>
Message-ID: <39682213.otHMo6zoRf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 June 2014 11:14:39 Will Deacon wrote:
> On Wed, Jun 18, 2014 at 12:37:16AM +0100, Thierry Reding wrote:
>   - Each master has a set of fixed StreamIDs
>   - StreamIDs can be remastered by adding a constant offset (this could also
>     be used to describe RequesterID -> StreamID mapping)
> 
> I'd hope this would be sufficient for most people. Dynamic ID assignment can
> be worked out later (I'm not even sure it belongs in this binding) and any
> mappings other than `add a constant offset' can be treated on a case-by-case
> basis. We don't want to throw the kitchen sink at a language for describing
> arbitrary transformations!
> 
> > We've had similar discussions before (power sequences anyone?) where we
> > tried to come up with a generic way to describe something in device tree
> > that just didn't work out too well. Some things are better done in code,
> > so I think we should at least consider that possibility rather than
> > blindly try and force everything into device tree.
> 
> If we can support 90% of SoCs with a simple DT-based description, we can
> address the corner cases as they arise. I'm not ruling our hardcoding
> topology if we have no choice, but I don't think that's a healthy place to
> start from.

So we could use the "arm,gicv3" comaptible string for all those that
have a relatively simple mapping, and describe that mapping entirely
in DT properties, but use a different compatible string for those
SoCs that have a mapping which we can't easily describe, and then
put that into code?

	Arnd
