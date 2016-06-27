From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Jun 2016 10:09:34 +0200
Subject: [PATCH] ARM: dts: sun7i: Add BCM53125 Device Tree nodes
In-Reply-To: <57701053.9090903@gmail.com>
References: <1465690459-30751-1-git-send-email-f.fainelli@gmail.com>
 <1465690459-30751-2-git-send-email-f.fainelli@gmail.com>
 <CAGb2v64u74cXG0R-MSMtDBxBpg2tFoifQwqbvWL-+3pG=GLVTQ@mail.gmail.com>
 <576F450B.3080207@gmail.com> <20160626080550.GG4000@lukather>
 <57701053.9090903@gmail.com>
Message-ID: <20160627080934.GS4000@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 26, 2016 at 10:26:43AM -0700, Florian Fainelli wrote:
> Le 26/06/2016 01:05, Maxime Ripard a ?crit :
> > Hi Florian,
> > 
> > On Sat, Jun 25, 2016 at 07:59:23PM -0700, Florian Fainelli wrote:
> >> Le 23/06/2016 22:48, Chen-Yu Tsai a ?crit :
> >>>> diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
> >>>> index 5ee43d8bf174..697582397dcf 100644
> >>>> --- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
> >>>> +++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
> >>>> @@ -110,13 +110,67 @@
> >>>>  &gmac {
> >>>>         pinctrl-names = "default";
> >>>>         pinctrl-0 = <&gmac_pins_rgmii_a>;
> >>>> -       phy = <&phy1>;
> >>>>         phy-mode = "rgmii";
> >>>>         phy-supply = <&reg_gmac_3v3>;
> >>>>         status = "okay";
> >>>>
> >>>> -       phy1: ethernet-phy at 1 {
> >>>> -               reg = <1>;
> >>>> +       fixed-link {
> >>>> +               speed = <1000>;
> >>>> +               full-duplex;
> >>>> +       };
> >>>> +
> >>>> +       mdio1 {
> >>>
> >>> mdio will suffice.
> >>
> >> There is another label in sun7i-a20.dtsi named mdio which is for the
> >> MDIO controller node matching allwinner,sun4i-a10-mdio, which is not the
> >> one we want here, we want the MDIO controller associated with the
> >> Synopsys GMAC.
> > 
> > Yes, but it's in a different node, and you're not using any labels, so
> > I don't really see how that would conflict.
> 
> Fair enough, I sent a v2 which uses "mdio-gmac" as a label, should I
> respin a v3 which just uses "mdio"?

Yes, please do, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160627/a5cbbb7b/attachment.sig>
