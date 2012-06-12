From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 12 Jun 2012 08:13:31 +0200
Subject: [PATCH v2 08/10] ARM: tegra: harmony: Initialize regulators from
 DT
In-Reply-To: <4FD664F8.4030800@wwwdotorg.org>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-9-git-send-email-thierry.reding@avionic-design.de>
 <4FD664F8.4030800@wwwdotorg.org>
Message-ID: <20120612061330.GD4040@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> On 06/11/2012 09:05 AM, Thierry Reding wrote:
> > Device tree support for the TPS6586x PMU used on Harmony has recently
> > been added. This commit adds the required device tree nodes to probe the
> > PMU from the device tree.
> 
> > diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
> 
> > +		tps6586x at 34 {
> > +			compatible = "ti,tps6586x";
> > +			reg = <0x34>;
> > +			interrupts = <0 88 0x4>;
> > +
> > +			#gpio-cells = <2>;
> > +			gpio-controller;
> > +
> > +			regulators {
> 
> Per the TPS65911 discussion on regulator bindings, this node should have:
> 
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 
> > +				sm0 {
> 
> Each of these nodes should be named regulator at 0, regulator at 1, etc.
> 
> Within each of these nodes, you need a matching reg property.
> 
> 	reg = <0>;
> 
> and something to identify which regulator within the chip this node
> configurations, although I don't think we've reached a final decision on
> the property name.
> 
> See the the following for details:
> 
> http://www.spinics.net/lists/linux-tegra/msg05577.html

Okay, I'll monitor that discussion and see what you end up with. I guess I'll
have to update the tps6586x binding when that decision has been reached and
add a patch to this series.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120612/d3908777/attachment.sig>
