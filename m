From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Nov 2017 16:46:57 +0100
Subject: [PATCH v2 11/18] drm/sun4i: Add A83T support
In-Reply-To: <2edae31575bbdb5abe989ad3b9d403a7@aosc.io>
References: <cover.d89f3ea4e1698f9343aef4852977c80edc75f21a.1511797218.git-series.maxime.ripard@free-electrons.com>
 <1c4f6b275597dec7d97b5c1d9f749ba27c0610f3.1511797218.git-series.maxime.ripard@free-electrons.com>
 <2744508.m82qQEPny3@jernej-laptop>
 <20171128090223.mqp3v2t6koyu6hk4@flea.home>
 <2edae31575bbdb5abe989ad3b9d403a7@aosc.io>
Message-ID: <20171128154657.cibnwdptkq36lj4l@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 07:50:19PM +0800, Icenowy Zheng wrote:
> ? 2017-11-28 17:02?Maxime Ripard ???
> > Hi,
> > 
> > On Mon, Nov 27, 2017 at 05:01:49PM +0100, Jernej ?krabec wrote:
> > > Dne ponedeljek, 27. november 2017 ob 16:41:35 CET je Maxime Ripard
> > > napisal(a):
> > > > Add support for the A83T display pipeline.
> > > >
> > > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 +++
> > > >  drivers/gpu/drm/sun4i/sun4i_drv.c                             | 2 ++
> > > >  drivers/gpu/drm/sun4i/sun4i_tcon.c                            | 5 +++++
> > > >  drivers/gpu/drm/sun4i/sun8i_mixer.c                           | 4 ++++
> > > >  4 files changed, 14 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > > > b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt index
> > > > d4259a4f5171..d6b52e5c48c0 100644
> > > > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > > > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > > > @@ -93,6 +93,7 @@ Required properties:
> > > >     * allwinner,sun6i-a31s-tcon
> > > >     * allwinner,sun7i-a20-tcon
> > > >     * allwinner,sun8i-a33-tcon
> > > > +   * allwinner,sun8i-a83t-tcon-lcd
> > > >     * allwinner,sun8i-v3s-tcon
> > > >   - reg: base address and size of memory-mapped region
> > > >   - interrupts: interrupt associated to this IP
> > > > @@ -224,6 +225,7 @@ supported.
> > > >
> > > >  Required properties:
> > > >    - compatible: value must be one of:
> > > > +    * allwinner,sun8i-a83t-de2-mixer
> > > 
> > > What will be the name of the second mixer, once support for HDMI is
> > > added?
> > > Should we start directly with 0 and 1 postfix ?
> > 
> > What are the differences exactly without the two mixers?
> > 
> > I was hoping to be able to cover them all using properties, indices
> > are usually pretty badly received in compatibles.
> 
> 1. VEP is only available on the VI channel in mixer0. (VEP may mean
> Video Enhance Processor)
> 2. Smart Backlight is only available in mixer0's on SoCs with LCD.
> 3. Writeback function is only available in mixer0.

Then yeah, we can totally support that using properties.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171128/29f5c6ff/attachment-0001.sig>
