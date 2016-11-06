From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 6 Nov 2016 19:50:59 +0100
Subject: [PATCH v2 2/9] drm/sun4i: support A33 tcon
In-Reply-To: <CAGb2v66q_07frb2k_A8mpeXT1SX3VdtNc5JbfR1hcK29iCXfQg@mail.gmail.com>
References: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
 <20160906144620.6322-3-maxime.ripard@free-electrons.com>
 <CAGb2v66q_07frb2k_A8mpeXT1SX3VdtNc5JbfR1hcK29iCXfQg@mail.gmail.com>
Message-ID: <20161106185059.uo2cb67wmquwtnuc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 05, 2016 at 11:54:28PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Tue, Sep 6, 2016 at 10:46 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The A33 has a significantly different pipeline, with components that differ
> > too.
> >
> > Make sure we had compatible for them.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 7 ++++++-
> >  drivers/gpu/drm/sun4i/sun4i_backend.c                         | 1 +
> >  drivers/gpu/drm/sun4i/sun4i_drv.c                             | 8 +++++---
> >  drivers/gpu/drm/sun4i/sun4i_tcon.c                            | 8 +++++++-
> >  4 files changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > index df8f4aeefe4c..bd3136a5cba5 100644
> > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > @@ -26,7 +26,9 @@ TCON
> >  The TCON acts as a timing controller for RGB, LVDS and TV interfaces.
> >
> >  Required properties:
> > - - compatible: value should be "allwinner,sun5i-a13-tcon".
> > + - compatible: value must be either:
> > +   * allwinner,sun5i-a13-tcon
> > +   * allwinner,sun8i-a33-tcon
> >   - reg: base address and size of memory-mapped region
> >   - interrupts: interrupt associated to this IP
> >   - clocks: phandles to the clocks feeding the TCON. Three are needed:
> > @@ -59,6 +61,7 @@ system.
> >  Required properties:
> >    - compatible: value must be one of:
> >      * allwinner,sun5i-a13-display-backend
> > +    * allwinner,sun8i-a33-display-backend
> >    - reg: base address and size of the memory-mapped region.
> >    - clocks: phandles to the clocks feeding the frontend and backend
> >      * ahb: the backend interface clock
> > @@ -80,6 +83,7 @@ deinterlacing and color space conversion.
> >  Required properties:
> >    - compatible: value must be one of:
> >      * allwinner,sun5i-a13-display-frontend
> > +    * allwinner,sun8i-a33-display-frontend
> 
> I just looked at the A23. It seems it's the same display frontend as the A33.
> Should we change the compatible string to a23 while it's still in RC?
> 
> The backend is probably different. The A33 only claims to support 2048x2048
> layers, while the A23 claims to support 8192x8192 layers.

I think we can still keep it. Especially if we're not sure, we might
need to make use of it in the future.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161106/3920c312/attachment.sig>
