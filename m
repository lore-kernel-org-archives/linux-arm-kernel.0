From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 6 Oct 2016 09:21:06 +0200
Subject: [PATCH v5 2/5] drm/bridge: Add RGB to VGA bridge support
In-Reply-To: <8795dc49-26f9-0505-f442-2ca74b51872f@codeaurora.org>
References: <20160930143709.1388-1-maxime.ripard@free-electrons.com>
 <20160930143709.1388-3-maxime.ripard@free-electrons.com>
 <8795dc49-26f9-0505-f442-2ca74b51872f@codeaurora.org>
Message-ID: <20161006072106.GA4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Archit,

On Mon, Oct 03, 2016 at 04:40:57PM +0530, Archit Taneja wrote:
> Hi Maxime,
> 
> On 09/30/2016 08:07 PM, Maxime Ripard wrote:
> >Some boards have an entirely passive RGB to VGA bridge, based on either
> >DACs or resistor ladders.
> >
> >Those might or might not have an i2c bus routed to the VGA connector in
> >order to access the screen EDIDs.
> >
> >Add a bridge that doesn't do anything but expose the modes available on the
> >screen, either based on the EDIDs if available, or based on the XGA
> >standards.
> >
> >Acked-by: Rob Herring <robh@kernel.org>
> >Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >---
> > .../bindings/display/bridge/rgb-to-vga-bridge.txt  |  48 +++++
> > drivers/gpu/drm/bridge/Kconfig                     |   7 +
> > drivers/gpu/drm/bridge/Makefile                    |   1 +
> > drivers/gpu/drm/bridge/rgb-to-vga.c                | 229 +++++++++++++++++++++
> > 4 files changed, 285 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt
> > create mode 100644 drivers/gpu/drm/bridge/rgb-to-vga.c
> >
> >diff --git a/Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt b/Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt
> >new file mode 100644
> >index 000000000000..a8375bc1f9cb
> >--- /dev/null
> >+++ b/Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt
> >@@ -0,0 +1,48 @@
> >+Dumb RGB to VGA bridge
> >+----------------------
> >+
> >+This binding is aimed for dumb RGB to VGA bridges that do not require
> >+any configuration.
> >+
> >+Required properties:
> >+
> >+- compatible: Must be "rgb-to-vga-bridge"
> 
> I'd talked to Laurent on IRC if he's okay with this. And I guess you to
> had discussed it during XDC too. He's suggested that it'd be better to
> have the compatible string as "simple-vga-dac".

I just wished this bikeshedding had taken place publicly and be
actually part of that discussion, but yeah, ok.

> Some of the reasons behind having this:
> 
> - We don't need to specify "rgb" in the compatible string since most
> simple VGA DACs can only work with an RGB input.

Ok.

> - Also, with "dac" specified in the string, we don't need to
> specifically mention "bridge" in the string. Also, bridge is a drm
> specific term.
>
> - "simple" is considered because it's an unconfigurable bridge, and it
> might be misleading for other VGA DACs to not use "vga-dac".

All those "simple" bindings are just the biggest lie we ever
told. It's simple when you introduce it, and then grows into something
much more complicated than a non-simple implementation.

> What do you think about this? If you think it's good, would it be
> possible for you to change this? I guess it's okay for the rest of
> the patch to stay the same.

I'll update and respin the serie.

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161006/701c158a/attachment.sig>
