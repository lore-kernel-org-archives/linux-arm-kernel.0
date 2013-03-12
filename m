From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 12 Mar 2013 17:10:41 +1300
Subject: [PATCH 3/6] arm: dts: vt8500: Update Wondermedia SoC dtsi files
 for pinctrl driver
In-Reply-To: <513E0A65.4000604@wwwdotorg.org>
References: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
 <1362807578-23089-4-git-send-email-linux@prisktech.co.nz>
 <513E0A65.4000604@wwwdotorg.org>
Message-ID: <1363061441.23051.6.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-03-11 at 10:46 -0600, Stephen Warren wrote:
> On 03/08/2013 10:39 PM, Tony Prisk wrote:
> > This patch adds pinctrl nodes to the VIA VT8500 and Wondermedia SoC dtsi
> > files to support the pinctrl driver.
> 
> > diff --git a/arch/arm/boot/dts/vt8500.dtsi b/arch/arm/boot/dts/vt8500.dtsi
> 
> > +		pinctrl: pinctrl at d8110000 {
> > +			compatible = "via,vt8500-pinctrl";
> > +			gpio-controller;
> > +			reg = <0xd8110000 0x10000>;
> > +			#gpio-cells = <2>;
> > +			wm,pinmux = <0x00000001 0x00000001>;
> > +		};
> 
> In the binding documentation, "wm,pinmux" is listed under "optional
> sub-node properties", but here the property is included in the main
> node, not a sub-node.
> 
> I'm a little confused what this property means then...
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Sorry - this was copied in large part from the brcm,bcm2835-gpio.txt
binding. I added wm,pinmux alongside the existing wm,pins, wm,function
and wm,pull properties.

You are correct that this shouldn't be listed as a subnode property.

Regards
Tony P
