From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Sep 2016 22:22:18 +0200
Subject: [PATCH 2/7] drm/sun4i: support A33 tcon
In-Reply-To: <CAGb2v67boPYN5oYXzgcdzx8Tyx0FAO5do6mV193CsQ_OUuY-2g@mail.gmail.com>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
 <20160901153204.11217-3-maxime.ripard@free-electrons.com>
 <CAGb2v67boPYN5oYXzgcdzx8Tyx0FAO5do6mV193CsQ_OUuY-2g@mail.gmail.com>
Message-ID: <20160905202218.GD8596@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2016 at 02:02:30PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Thu, Sep 1, 2016 at 11:31 PM, Maxime Ripard
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
> > index df8f4aeefe4c..d467ea93ac08 100644
> > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > @@ -26,7 +26,9 @@ TCON
> >  The TCON acts as a timing controller for RGB, LVDS and TV interfaces.
> >
> >  Required properties:
> > - - compatible: value should be "allwinner,sun5i-a13-tcon".
> > + - compatible: value must be either:
> > +   * allwinner,sun5i-a13-tcon
> > +   * allwinner,sun8i-a23-tcon
> 
> From what I can tell from the manuals, the A23 TCON and A33 TCON are
> slightly different. The A23 TCON has channel 1, and it also has DMA
> input. A33 has neither. (Though the DMA chart still lists the TCON DRQ.)
> 
> I think we should have separate compatibles for them. If you think
> otherwise you should mention it in the commit message.

Ack, i will change it in the v2.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/954bf4e8/attachment-0001.sig>
