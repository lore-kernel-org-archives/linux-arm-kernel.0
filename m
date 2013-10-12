From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 12 Oct 2013 17:29:00 +0200
Subject: [PATCHv2 1/9] ARM: kirkwood: convert d2net_v2 to DT
In-Reply-To: <20130813095830.GI27165@e106331-lin.cambridge.arm.com>
References: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375369655-1310-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130813095830.GI27165@e106331-lin.cambridge.arm.com>
Message-ID: <20131012172900.787c68eb@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark Rutland,

On Tue, 13 Aug 2013 10:58:30 +0100, Mark Rutland wrote:

> > +       regulators {
> > +               compatible = "simple-bus";
> > +               pinctrl-0 = <&pmx_sata_power>;
> > +               pinctrl-names = "default";
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> 
> That's not really a simple-bus if there's no mapping to the parent's
> address space (and it represents a completely different concept of
> address).

Right, but I guess it is needed for the child nodes to be considered as
platform devices. There are already gazillions of .dts doing this in
arch/arm/boot/dts, not only Kirkwood platforms, but also Tegra
platforms, i.MX platforms and a bunch of others. While I admit it
doesn't look the most appropriate representation, I believe that
considering the number of existing users, solving this problem is a
separate matter to the conversion of the d2net_v2 to the Device Tree.

> Could you explain what the pinctrl's doing here? I couldn't see what
> code would be handling that given the node will get probed as a
> simple-bus and the regulator-fixed binding doesn't mention anything
> about the parent node.

Right, the pinctrl should be one-level down, in the DT sub-node that
describes the regulator, so that it get automatically configured
because the regulator driver is a platform_driver.

I'll fix this.

> > +
> > +               sata0_power: regulator at 1 {
> > +                       compatible = "regulator-fixed";
> > +                       reg = <1>;
> 
> Do we even need the unit-address?

No, I'll fix this one as well.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
