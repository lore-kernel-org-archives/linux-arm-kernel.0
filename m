From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Jan 2017 20:15:14 +0100
Subject: [PATCH v2 6/6] arm64: allwinner: a64: Increase the MMC max
 frequency
In-Reply-To: <CAGb2v67JoOAtHjMJboNUdCDX=+=Hf+zOWr234rT7GEiUmPb=nQ@mail.gmail.com>
References: <cover.493dc67855a5f1837e875d37307319a03d14d1d0.1483980339.git-series.maxime.ripard@free-electrons.com>
 <3689701f93c8426bfa476e9a5f31c3642a8a898e.1483980339.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67JoOAtHjMJboNUdCDX=+=Hf+zOWr234rT7GEiUmPb=nQ@mail.gmail.com>
Message-ID: <20170110191514.kgbesffn3xqltnol@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 10, 2017 at 01:01:20AM +0800, Chen-Yu Tsai wrote:
> On Tue, Jan 10, 2017 at 12:46 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > All the controllers can have a maximum frequency of 200MHz.
> >
> > Since older SoCs cannot go that high, we cannot change the default maximum
> > frequency, but fortunately for us we have a property for that in the DT.
> >
> > This also has the side effect of allowing to use the MMC HS200 mode for the
> > boards that support it (with either 1.2v or 1.8v IOs).
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 3 +++
> >  1 file changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > index 8e149498e096..f46ae965cf5b 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > @@ -332,6 +332,7 @@
> >                         resets = <&ccu RST_BUS_MMC0>;
> >                         reset-names = "ahb";
> >                         interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> > +                       max-frequency = <200000000>;
> 
> You also have to set one of MMC_CAP2_HS200* in the driver,
> or mmc-hs200-1_8v or mmc-hs200-1_2v in the device tree to
> actually use HS200, right?

Yes, but that requires a board with 1.8V IOs to work properly, which
not all board use, so it's probably best to enable it in the board
DTS.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170110/de9c272e/attachment.sig>
