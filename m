From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 May 2017 09:24:37 +0200
Subject: [linux-sunxi] [PATCH 4/6] ARM: sun8i: a83t: Add device node for
 DMA controller
In-Reply-To: <CAEKpxB=daPuD0YNToTiEzcD0VAUjVen0nTDY0BhkLfQzcLFoTw@mail.gmail.com>
References: <20170522062552.19026-1-wens@csie.org>
 <20170522062552.19026-5-wens@csie.org>
 <CAEKpxB=daPuD0YNToTiEzcD0VAUjVen0nTDY0BhkLfQzcLFoTw@mail.gmail.com>
Message-ID: <20170522072437.hoekcjfxi5i3oxiu@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Mon, May 22, 2017 at 09:18:49AM +0200, Code Kipper wrote:
> On 22 May 2017 at 08:25, Chen-Yu Tsai <wens@csie.org> wrote:
> > The A83T SoC has a DMA controller that supports 8 DMA channels
> > to and from various peripherals.
> >
> > Add a device node for it.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  arch/arm/boot/dts/sun8i-a83t.dtsi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > index e12dd7170b8f..47196feda26b 100644
> > --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > @@ -163,6 +163,15 @@
> >                 #size-cells = <1>;
> >                 ranges;
> >
> > +               dma: dma-controller at 1c02000 {
> > +                       compatible = "allwinner,sun8i-a83t-dma";
> > +                       reg = <0x01c02000 0x1000>;
> > +                       interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks = <&ccu 21>;
> > +                       resets = <&ccu 7>;
>
> these should be ccu defines, otherwise everything else looks great.

In general, yes. In this particular case however, this is made on
purpose, since Chen-Yu just introduced those defines that are part of
a commit that will go in a different tree.

We will switch to the defines once it reaches Linus' tree.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170522/b75b07d0/attachment.sig>
