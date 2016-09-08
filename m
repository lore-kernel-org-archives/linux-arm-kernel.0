From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Sep 2016 09:29:19 +0200
Subject: [PATCH v2 2/9] drm/sun4i: support A33 tcon
In-Reply-To: <CAGb2v670juZTMovDZCoiW00d3otrBbOWwQXp0NzNeT6sP6zocA@mail.gmail.com>
References: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
 <20160906144620.6322-3-maxime.ripard@free-electrons.com>
 <CAGb2v670juZTMovDZCoiW00d3otrBbOWwQXp0NzNeT6sP6zocA@mail.gmail.com>
Message-ID: <20160908072919.GE8913@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 11:16:33PM +0800, Chen-Yu Tsai wrote:
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
> 
> You should probably put a note saying the A33 only needs 2 clocks.
> You can keep my ack after fixing it.

I did while applying, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/eeaaa040/attachment.sig>
