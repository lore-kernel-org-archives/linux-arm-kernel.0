From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 03 Sep 2012 14:28:32 +0200
Subject: [PATCH 6/6] ARM: Exynos: Add basic dts file for Samsung Trats
 board
In-Reply-To: <CAJuYYwSPfEk7fkcR=vP0GmSe924BJPNwoO=1CaSXX3zUFWwBoQ@mail.gmail.com>
References: <1346311903-15920-1-git-send-email-t.figa@samsung.com>
 <1346311903-15920-7-git-send-email-t.figa@samsung.com>
 <CAJuYYwSPfEk7fkcR=vP0GmSe924BJPNwoO=1CaSXX3zUFWwBoQ@mail.gmail.com>
Message-ID: <1968975.iys2N65Q5Y@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Thanks for reviewing the patch.

On Friday 31 of August 2012 09:54:20 Thomas Abraham wrote:
> > +       wakeup_eint: interrupt-controller-wakeup-eint {
> > +               compatible = "samsung,exynos4210-wakeup-eint";
> > +               reg = <0x11000000 0x1000>;
> > +               #interrupt-cells = <2>;
> > +               interrupt-controller;
> > +               interrupts =    <0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
> > +                               <0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>,
> > +                               <0 24 0>, <0 25 0>, <0 26 0>, <0 27 0>,
> > +                               <0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>,
> > +                               <0 32 0>;
> > +       };
> 
> The external wakeup node should be in the exynos4.dtsi file since this
> is common across all Exynos4 SoC's. Besides, the device tree support
> patches for wakeup-interrupts is not being pursed anymore, since it is
> now handled in pinctrl driver itself. So it would be better not to
> include this node.

Right. We will eventually add support for external wakeup sources using 
pinctrl.

> > +       spi_2: spi at 13940000 {
> > +               status = "disabled";
> > +       };
> > +};
> 
> If we choose to mark the nodes in dtsi files as "disabled" then we can
> avoid these here.

OK.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
