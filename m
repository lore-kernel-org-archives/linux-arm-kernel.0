From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Thu, 25 May 2017 10:10:55 +0300
Subject: [PATCH v2 1/2] ARM: dts: orange-pi-zero: specify wifi interrupts
In-Reply-To: <CAGb2v647GTQW9-ZYrkWS7RoeYTu_7oTm8v4PDs0YD1pZ8oUohQ@mail.gmail.com>
References: <20170524212433.14386-1-geomatsi@gmail.com>
 <20170524212433.14386-2-geomatsi@gmail.com>
 <CAGb2v647GTQW9-ZYrkWS7RoeYTu_7oTm8v4PDs0YD1pZ8oUohQ@mail.gmail.com>
Message-ID: <20170525071055.xdd4sbpnzlkg7wa2@speedy.hunter>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > index 9e8b082c134f..e97dfd1775d1 100644
> > --- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> > @@ -128,6 +128,9 @@
> >          */
> >         xr819: sdio_wifi at 1 {
> >                 reg = <1>;
> > +               compatible = "xradio,xr819";
> 
> You should submit device tree bindings first. See:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/net/wireless
> 
> for examples.

Does it make sense for the out-of-tree driver ?

> > +               interrupt-parent = <&pio>;
> > +               interrupts = <6 10 IRQ_TYPE_EDGE_RISING>;
> 
> Are these optional or required properties? AFAIK SDIO supports in-band
> interrupts with a bit of overhead, so they should be optional.

Those properties are optional. Driver works anyway, though it complains about
missing interrupts. IIUC xradio driver falls back to polling mode only if
xr819 interrupt configuraton is not specified.


Regards,
Sergey
