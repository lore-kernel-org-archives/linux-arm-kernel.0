From: robh@kernel.org (Rob Herring)
Date: Wed, 13 Sep 2017 09:34:15 -0500
Subject: [PATCH 2/7] dt-bindings: gpu: mali-utgard: add optional supply
 regulator
In-Reply-To: <5517832.4TA9c0NYD6@diego>
References: <20170905105739.8330-1-heiko@sntech.de>
 <20170905105739.8330-3-heiko@sntech.de>
 <20170912220920.nfg33wbqikja3gml@rob-hp-laptop>
 <5517832.4TA9c0NYD6@diego>
Message-ID: <20170913143415.fcds556hdqwnhsvm@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 13, 2017 at 12:12:24AM +0200, Heiko St?bner wrote:
> Hi Rob,
> 
> Am Dienstag, 12. September 2017, 17:09:20 CEST schrieb Rob Herring:
> > On Tue, Sep 05, 2017 at 12:57:34PM +0200, Heiko Stuebner wrote:
> > > Mali GPUs have a separate supplying regulator in a lot of socs,
> > > so describe a mali-supply property. The already described
> > > operating points will likely also need access to this regulator.
> > > 
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > > 
> > >  Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> > > b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt index
> > > 3b7f6f72f032..bcaa640c883f 100644
> > > --- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> > > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> > > 
> > > @@ -39,6 +39,9 @@ Optional properties:
> > >      Memory region to allocate from, as defined in
> > >      Documentation/devicetree/bindi/reserved-memory/reserved-memory.txt
> > > 
> > > +  - mali-supply : Phandle to regulator for the Mali device. Refer to
> > > +    Documentation/devicetree/bindings/regulator/regulator.txt for
> > > details.
> > 
> > Wouldn't a power domain be more appropriate?
> 
> At least on Rockchip socs there is a power-domain, but also the separate 
> additional regulator. See the similar mali-midgard binding.

And that regulator's state is independent of the power domain's state? 

But I guess OPPs need a regulator. Really we should allow OPPs to be 
tied to the power domain. Maybe we do, I can't keep up with the ever 
evolving PM stuff.

So, given we already have it for midgard,

Acked-by: Rob Herring <robh@kernel.org>

Rob
