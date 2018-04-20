From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 20 Apr 2018 10:17:42 +0200
Subject: bq27000: directory/files exists even when hardware is not
 available
In-Reply-To: <20180420074826.c7cy4z3tq7c56ccs@pali>
References: <20180420074036.GA16257@amd> <20180420074826.c7cy4z3tq7c56ccs@pali>
Message-ID: <20180420081741.GA8856@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2018-04-20 09:48:26, Pali Roh?r wrote:
> On Friday 20 April 2018 09:40:36 Pavel Machek wrote:
> > Hi!
> > 
> > On droid4 (4.17-rc1), /sys/class/power_supply/bq27000-battery exists
> > even when hardware is not present (as on Droid 4).
> > 
> > Any ideas?
> > 									Pavel
> 
> Somebody must have registered bq device into power_supply subsystem.
> Maybe DT note is present?

No, I don't think so:

pavel at duo:/data/l/linux-n900$ grep bq27 arch/arm/boot/dts/*
Binary file arch/arm/boot/dts/omap3-n900.dtb matches
arch/arm/boot/dts/omap3-n900.dts:	     bq27200: bq27200 at 55 {
arch/arm/boot/dts/omap3-n900.dts:	     	      compatible =
"ti,bq27200";
arch/arm/boot/dts/omap3-n900.dts~:	bq27200: bq27200 at 55 {
arch/arm/boot/dts/omap3-n900.dts~:		 compatible =
"ti,bq27200";
arch/arm/boot/dts/omap3-n900.dts.orig:	bq27200: bq27200 at 55 {
arch/arm/boot/dts/omap3-n900.dts.orig:		 compatible =
"ti,bq27200";
Binary file arch/arm/boot/dts/omap3-n950.dtb matches
arch/arm/boot/dts/omap3-n950-n9.dtsi:	     bq27521: bq27521 at 55 {
arch/arm/boot/dts/omap3-n950-n9.dtsi:	     	      compatible =
"ti,bq27521";
arch/arm/boot/dts/omap3-n950-n9.dtsi~:	bq27521: bq27521 at 55 {
arch/arm/boot/dts/omap3-n950-n9.dtsi~:		 compatible =
"ti,bq27521";
arch/arm/boot/dts/omap3-n950-n9.dtsi.orig:	bq27521: bq27521 at 55 {
arch/arm/boot/dts/omap3-n950-n9.dtsi.orig:		 compatible =
"ti,bq27521";
Binary file arch/arm/boot/dts/omap3-n9.dtb matches
arch/arm/boot/dts/omap3-pandora-common.dtsi:	bq27500 at 55 {
arch/arm/boot/dts/omap3-pandora-common.dtsi:		   compatible
= "ti,bq27500";
arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts:
bq27541 at 55 {
arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts:
compatible = "ti,bq27541";
arch/arm/boot/dts/rk3288-veyron-minnie.dts:	battery: bq27500 at 55 {
arch/arm/boot/dts/rk3288-veyron-minnie.dts:		 compatible =
"ti,bq27500";
pavel at duo:/data/l/linux-n900$


Is it possible that one wire subsystem registers bq27000 even without
device tree node?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180420/d2541b5b/attachment-0001.sig>
