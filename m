From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Jan 2017 22:06:38 +0100
Subject: [PATCH 4/4] ARM: dts: sun8i: add OTG function to Lichee Pi Zero
In-Reply-To: <20170111200811.GA16865@uda0271908>
References: <20170103152534.20118-1-icenowy@aosc.xyz>
 <20170103152534.20118-5-icenowy@aosc.xyz>
 <20170110202443.GC2479@uda0271908>
 <2733831484164533@web1g.yandex.ru>
 <20170111200811.GA16865@uda0271908>
Message-ID: <20170111210638.ppdnpzdd2l6x4lyo@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 02:08:11PM -0600, Bin Liu wrote:
> On Thu, Jan 12, 2017 at 03:55:33AM +0800, Icenowy Zheng wrote:
> > 
> > 
> > 11.01.2017, 04:24, "Bin Liu" <b-liu@ti.com>:
> > > On Tue, Jan 03, 2017 at 11:25:34PM +0800, Icenowy Zheng wrote:
> > >> ?Lichee Pi Zero features a USB OTG port.
> > >>
> > >> ?Add support for it.
> > >>
> > >> ?Note: in order to use the Host mode, the board must be powered via the
> > >> ?+5V and GND pins.
> > >>
> > >> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> > >> ?---
> > >> ??arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts | 10 ++++++++++
> > >> ??1 file changed, 10 insertions(+)
> > >>
> > >> ?diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
> > >> ?index 0099affc6ce3..3d9168cbaeca 100644
> > >> ?--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
> > >> ?+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
> > >> ?@@ -71,3 +71,13 @@
> > >> ??????????pinctrl-names = "default";
> > >> ??????????status = "okay";
> > >> ??};
> > >> ?+
> > >> ?+&usb_otg {
> > >> ?+ dr_mode = "otg";
> > >
> > > Why not set this default mode in dtsi instead?
> > >
> > > Regards,
> > > -Bin.
> > 
> > There's possibly boards which do not have OTG functions.
> 
> That is board specific.

Exactly, and this is why it should be done in the board DT.

The controller in the Allwinner SoCs do not handle directly the ID pin
and VBUS, but rather rely on a GPIO to do so.

So boards with OTG will need setup anyway, at least to tell which
GPIOs are used. There's no point in enforcing a default if it doesn't
work by default.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170111/2d54e75b/attachment.sig>
