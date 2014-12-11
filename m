From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Dec 2014 22:15:50 +0100
Subject: [PATCHv2 3/3] ARM:dts:sunxi:ps2 dt nodes for A10/A20 PS2
 controller.
In-Reply-To: <CAEzqOZu49Z99B4DWvuD=E2BKs7ihSVAunshheUn=Z-VAqivUxA@mail.gmail.com>
Message-ID: <20141211211550.GJ8739@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please keep the Cc list.

On Wed, Dec 10, 2014 at 01:39:52AM +0530, Vishnu Patekar wrote:
> > > --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > > +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > > @@ -112,6 +112,19 @@
> > >                       pinctrl-0 = <&uart0_pins_a>;
> > >                       status = "okay";
> > >               };
> > > +             /* PS2 0 and PS2 1 are disabled by default
> > > +             To enable PS2 0 and PS2 1 uncomment below ps20 and ps21
> > nodes
> > > +             Please note that ps20 pins conflict with HDMI on Lime2
> > Board*/
> > > +             /*ps20: ps2 at 0x01c2a000 {
> > > +                     pinctrl-names = "default";
> > > +                     pinctrl-0 = <&ps2_0_pins>;
> > > +                     status = "okay";
> > > +             };
> > > +             ps21: ps2 at 0x01c2a400 {
> > > +                     pinctrl-names = "default";
> > > +                     pinctrl-0 = <&ps2_1_pins>;
> > > +                     status = "okay";
> > > +             };*/
> >
> > Hmmm, no, no comments in the DTS.
> >
> > Especially when it's that trivial to enable.
>
> Okie, I'll just keep ps20 and ps21 nodes commented.

No, the comments themselves were great. But the nodes themselves
shouldn't be there in the first place.

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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141211/5d19ded5/attachment.sig>
