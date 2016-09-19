From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Sep 2016 11:23:16 +0200
Subject: [PATCH v3 1/4] drm/bridge: Add RGB to VGA bridge support
In-Reply-To: <1682784.hDdFQltm22@avalon>
References: <20160908121751.16911-1-maxime.ripard@free-electrons.com>
 <20160908121751.16911-2-maxime.ripard@free-electrons.com>
 <2115773.yQojqqIjGI@avalon> <1682784.hDdFQltm22@avalon>
Message-ID: <20160919092316.GH8719@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 18, 2016 at 01:04:17PM +0300, Laurent Pinchart wrote:
> On Sunday 18 Sep 2016 13:01:16 Laurent Pinchart wrote:
> > On Thursday 08 Sep 2016 14:17:48 Maxime Ripard wrote:
> > > Some boards have an entirely passive RGB to VGA bridge, based on either
> > > DACs or resistor ladders.
> > > 
> > > Those might or might not have an i2c bus routed to the VGA connector in
> > > order to access the screen EDIDs.
> > > 
> > > Add a bridge that doesn't do anything but expose the modes available on
> > > the screen, either based on the EDIDs if available, or based on the XGA
> > > standards.
> > > 
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > ---
> > > 
> > >  .../bindings/display/bridge/rgb-to-vga-bridge.txt  |  52 +++++
> > >  drivers/gpu/drm/bridge/Kconfig                     |   6 +
> > >  drivers/gpu/drm/bridge/Makefile                    |   1 +
> > >  drivers/gpu/drm/bridge/rgb-to-vga.c                | 232 ++++++++++++++++
> > >  4 files changed, 291 insertions(+)
> > >  create mode 100644
> > > 
> > > Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt
> > > create mode 100644 drivers/gpu/drm/bridge/rgb-to-vga.c
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt
> > > b/Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt
> > > new file mode 100644
> > > index 000000000000..83a053fb51a0
> > > --- /dev/null
> > > +++
> > > b/Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt
> > > @@ -0,0 +1,52 @@
> > > +Passive RGB to VGA bridge
> > > +-------------------------
> > > +
> > > +This binding is aimed for entirely passive RGB to VGA bridges that do not
> > > +require any configuration.
> > 
> > Couldn't it also support active RGB to VGA bridges that don't require any
> > configuration ? It would seem a bit pointless to define a separate DT
> > binding for them.
> 
> I'm thinking in particular about the ADV7123
> (http://www.analog.com/media/en/technical-documentation/data-sheets/ADV7123.pdf)
> that already has a DT binding.

I guess we don't have the same definition of passive, but I was
thinking of devices that do not need any configuration in order to
operate properly. And this one seems to fall in that category.

> Would it be feasible to combine the two, and support both devices
> with a single driver ?

I don't see why not. But converting the renesas DRM driver seems a bit
out of scope, and the ADV compatible can definitely be added later.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160919/22fa2cec/attachment.sig>
