From: contact@paulk.fr (Paul Kocialkowski)
Date: Tue, 20 Sep 2016 20:14:49 +0200
Subject: [PATCH 1/4] ARM: tegra: nyan: Use proper IRQ type definitions
In-Reply-To: <ef69b6d2-ce6b-ff76-5c04-ab2176eb6ecc@nvidia.com>
References: <20160828173246.32621-1-contact@paulk.fr>
 <ef69b6d2-ce6b-ff76-5c04-ab2176eb6ecc@nvidia.com>
Message-ID: <1474395289.1215.20.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mardi 20 septembre 2016 ? 18:15 +0100, Jon Hunter a ?crit?:
> On 28/08/16 18:32, Paul Kocialkowski wrote:
> > 
> > This switches a few interrupt definitions that were using
> > GPIO_ACTIVE_HIGH as IRQ type, which is invalid.
> 
> May be you are right, but this does not describe why this is invalid.
> Can you elaborate?

GPIO_ACTIVE_HIGH is simply not the right kind of define to use in the
"interrupts" devicetree property. Values provided there are understood as
IRQ_TYPE_ defines.

Also, a similar commit[0] was pushed to the cros kernel tree.

Cheers,

[0]:?https://chromium.googlesource.com/chromiumos/third_party/kernel/+/f77288938d571b48c9736ac3703cea370c002434

> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> > ?arch/arm/boot/dts/tegra124-nyan.dtsi | 4 ++--
> > ?1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi
> > b/arch/arm/boot/dts/tegra124-nyan.dtsi
> > index 271505e..30a77ec 100644
> > --- a/arch/arm/boot/dts/tegra124-nyan.dtsi
> > +++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
> > @@ -59,7 +59,7 @@
> > ?			compatible = "maxim,max98090";
> > ?			reg = <0x10>;
> > ?			interrupt-parent = <&gpio>;
> > -			interrupts = <TEGRA_GPIO(H, 4) GPIO_ACTIVE_HIGH>;
> > +			interrupts = <TEGRA_GPIO(H, 4)
> > IRQ_TYPE_EDGE_FALLING>;
> 
> If this in invalid then the DT binding doc for the max98090 should be
> updated as well.
> 
> > 
> > ?		};
> > ?
> > ?		temperature-sensor at 4c {
> > @@ -325,7 +325,7 @@
> > ?					reg = <0x9>;
> > ?					interrupt-parent = <&gpio>;
> > ?					interrupts = <TEGRA_GPIO(J, 0)
> > -							GPIO_ACTIVE_HIGH>;
> > +							IRQ_TYPE_EDGE_BOTH>
> > ;
> > ?					ti,ac-detect-gpios = <&gpio
> > ?							TEGRA_GPIO(J, 0)
> > ?							GPIO_ACTIVE_HIGH>;
> > 
> 
> Cheers
> Jon
> 
-- 
Paul Kocialkowski, developer of low-level free software for embedded devices

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160920/cc2229e4/attachment.sig>
