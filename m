From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Dec 2017 10:39:45 +0100
Subject: [linux-sunxi] [PATCH v4 09/10] ARM: dtsi: axp81x: add GPIO DT node
In-Reply-To: <CAGb2v65mOwNBdit=gKOq0=iv94FNuH__4yvCw4v0NHYiCKccBw@mail.gmail.com>
References: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
 <af90c57ebf97c8f5504a4b5b1dad3638bedadfef.1512135804.git-series.quentin.schulz@free-electrons.com>
 <CAGb2v65mOwNBdit=gKOq0=iv94FNuH__4yvCw4v0NHYiCKccBw@mail.gmail.com>
Message-ID: <20171205093945.5sudt23fag7q3ric@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 05, 2017 at 05:24:47PM +0800, Chen-Yu Tsai wrote:
> On Fri, Dec 1, 2017 at 9:44 PM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
> > This adds DT node for the GPIO/pinctrl part present in AXP813/AXP818.
> >
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/axp81x.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
> > index 73b761f..0ef959d 100644
> > --- a/arch/arm/boot/dts/axp81x.dtsi
> > +++ b/arch/arm/boot/dts/axp81x.dtsi
> > @@ -48,6 +48,12 @@
> >         interrupt-controller;
> >         #interrupt-cells = <1>;
> >
> > +       axp_gpio: axp-gpio {
> > +               compatible = "x-powers,axp813-gpio";
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> 
> What about interrupt-controller for directly referenced interrupts from
> the GPIO pins?

There's a bit more to it to enable interrupts. You would probably need
to set up a chained interrupt controller in the GPIO driver, and in
the DTS with a interrupt-parent and interrupts properties pointing to
the AXP device itself.

> Otherwise,
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied 9 and 10, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171205/19eb2779/attachment.sig>
