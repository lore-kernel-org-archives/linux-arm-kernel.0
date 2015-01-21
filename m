From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Jan 2015 13:23:29 +0100
Subject: [linux-sunxi] [PATCH v4 5/5] ARM: sunxi: dts: Add PS2 nodes for
 A20 lime2 board
In-Reply-To: <CAEzqOZsWYQ+Aep6HBZXVtKGEJgKYAKJU2b0=nGvP0jPKECxn7g@mail.gmail.com>
References: <1421417021-3247-1-git-send-email-vishnupatekar0510@gmail.com>
 <1421417021-3247-6-git-send-email-vishnupatekar0510@gmail.com>
 <54BE8A0E.30604@gmail.com> <20150120200740.GY4367@lukather>
 <CAEzqOZsWYQ+Aep6HBZXVtKGEJgKYAKJU2b0=nGvP0jPKECxn7g@mail.gmail.com>
Message-ID: <20150121122329.GG4367@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 04:34:45PM +0530, Vishnu Patekar wrote:
> Hello,
> 
> On Wed, Jan 21, 2015 at 1:37 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> >
> > On Tue, Jan 20, 2015 at 05:02:06PM +0000, Iain Paton wrote:
> > > On 16/01/15 14:03, Vishnu Patekar wrote:
> > > > Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>
> > > > ---
> > > >  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts |   12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > > > index ed364d5..3365f12 100644
> > > > --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > > > +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > > > @@ -113,6 +113,18 @@
> > > >                     status = "okay";
> > > >             };
> > > >
> > > > +           ps20: ps2 at 01c2a000 {
> > > > +                   pinctrl-names = "default";
> > > > +                   pinctrl-0 = <&ps20_pins_a>;
> > > > +                   status = "okay";
> > > > +           };
> > > > +
> > > > +           ps21: ps2 at 01c2a400 {
> > > > +                   pinctrl-names = "default";
> > > > +                   pinctrl-0 = <&ps21_pins_a>;
> > > > +                   status = "okay";
> > > > +           };
> > > > +
> > > >             i2c0: i2c at 01c2ac00 {
> > > >                     pinctrl-names = "default";
> > > >                     pinctrl-0 = <&i2c0_pins_a>;
> > > >
> > >
> > > As the Lime2 doesn't actually have any PS2 connectors on the board,
> > > I'd prefer that these are not enabled unconditionally. Doing so
> > > only makes it more difficult for people who want to use these pins
> > > for other functions.
> > >
> > > Device tree overlays seem to be close to being merged, perhaps we
> > > could leave enabling this to an overlay?
> >
> > I already had the exact same reasoning, and this was even removed at
> > some point. For some reason, it was added back, and I don't really
> > know why.
> This was removed in consideration that these pins conflict with HDMI,
> however, these is not conflict.
> 
> It was kept there as an example. But, as there is no ps2 connector on
> board, I've no problem to remove these nodes from Lime2 dts file.

Yet, probing a driver for a device connected to floating lines sounds
like a pretty bad idea.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150121/8417c5ae/attachment.sig>
