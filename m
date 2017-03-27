From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 27 Mar 2017 22:38:45 +0800
Subject: [PATCH 0/2] drm/sun4i: Add display backend interrupt to dt binding
Message-ID: <20170327143847.16259-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

As promised, here is the patch adding the interrupt line for the display
backend to the sun5i shared dtsi, and another one adding it to the device
tree bindings.

The display backend has an undocumented (in the user manual) interrupt
that, according to vendor code, is raised when the current scanout is
completed. This might be a better fit for DRM/KMS vblank signalling,
rather than the TCON's vblank interrupt. If true, it would allow us
to cut out the TCON from the crtc in the driver, instead keeping it
solely as an encoder, simplifying some of the inter-component code.

Regardless, the interrupt line exists and should be added to the
device tree.


Regards
ChenYu

Chen-Yu Tsai (2):
  drm/sun4i: Add display backend interrupt to device tree binding
  ARM: dts: sun5i: Add interrupt for display backend

 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 2 ++
 arch/arm/boot/dts/sun5i.dtsi                                  | 1 +
 2 files changed, 3 insertions(+)

-- 
2.11.0
