From: sre@ring0.de (Sebastian Reichel)
Date: Tue, 12 Nov 2013 21:05:14 +0100
Subject: [PATCH 4/5 v2] input: tc3589x-keypad: support probing from
 device tree
In-Reply-To: <CACRpkdb_bryGJo7CKGP5tj3RFGv=Gh+Q5m9ucVKqJ068tjPC2g@mail.gmail.com>
References: <1384265618-10590-1-git-send-email-linus.walleij@linaro.org>
 <20131112153057.GA9683@earth.universe>
 <CACRpkdb_bryGJo7CKGP5tj3RFGv=Gh+Q5m9ucVKqJ068tjPC2g@mail.gmail.com>
Message-ID: <20131112200514.GA15413@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 06:06:49PM +0100, Linus Walleij wrote:
> On Tue, Nov 12, 2013 at 4:30 PM, Sebastian Reichel <sre@ring0.de> wrote:
> > On Tue, Nov 12, 2013 at 03:13:38PM +0100, Linus Walleij wrote:
> 
> >> +     plat->no_autorepeat = of_property_read_bool(np, "linux,no-autorepeat");
> >> +     plat->enable_wakeup = of_property_read_bool(np, "linux,wakeup");
> >
> > There is currently discussion going on for the property name of
> > autorepeat:
> >
> > https://lkml.org/lkml/2013/11/11/680
> 
> So this binding is documented for GPIO keys in:
> Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
> 
> This is probably the most used binding as GPIO matrixes are
> not uncommon. But I don't know, yes it is a mess. (As usual.)

I could find two boards using "gpio-matrix-keypad" in the mainline
kernel and not a single instance of "linux,no-autorepeat":

arch $ grep "gpio-matrix-keypad" **/*.dts **/*.dtsi
arm/boot/dts/am335x-evm.dts:               compatible = "gpio-matrix-keypad";
powerpc/boot/dts/ac14xx.dts:               compatible = "gpio-matrix-keypad";

arch $ grep "autorepeat" **/*.dts **/*.dtsi
arch/arm/boot/dts/am335x-evm.dts:          autorepeat;
arch/arm/boot/dts/ea3250.dts:              autorepeat;
arch/arm/boot/dts/exynos4210-smdkv310.dts: linux,keypad-no-autorepeat;
arch/arm/boot/dts/exynos4412-origen.dts:   linux,keypad-no-autorepeat;
arch/arm/boot/dts/exynos4412-smdk4412.dts: linux,keypad-no-autorepeat;
arch/arm/boot/dts/omap4-sdp.dts:           linux,input-no-autorepeat;
arch/arm/boot/dts/spear1310-evb.dts:       autorepeat;
arch/arm/boot/dts/spear1340-evb.dts:       autorepeat;
arch/arm/boot/dts/spear300-evb.dts:        autorepeat;
arch/arm/boot/dts/ste-stuib.dtsi:          st,no-autorepeat;

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131112/4a785fd2/attachment.sig>
