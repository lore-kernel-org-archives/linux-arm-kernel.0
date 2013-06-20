From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 20 Jun 2013 13:42:43 +0200
Subject: [PATCH V6 3/3] ARM: dts: Add pcie controller node for Samsung
 EXYNOS5440 SoC
In-Reply-To: <00d801ce6da5$fa792d80$ef6b8880$@samsung.com>
References: <00c201ce6d85$83b072a0$8b1157e0$@samsung.com>
 <201306201216.37248.arnd@arndb.de>
 <00d801ce6da5$fa792d80$ef6b8880$@samsung.com>
Message-ID: <1490597.TZb2cDc7ca@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 of June 2013 20:04:47 Jingoo Han wrote:
> On Thursday, June 20, 2013 7:17 PM, Arnd Bergmann wrote:
> > On Thursday 20 June 2013, Jingoo Han wrote:
> > > 2. patch adding label to the pinctrl node (which is a prerequisite)
> > > and
> > > 
> > >     board-specific properties of PCIe nodes.
> > >    
> > >    [PATCH] ARM: dts: Add pcie controller node for exynos5440-ssdk5440
> > > 
> > > arch/arm/boot/dts/exynos5440-ssdk5440.dts
> > > +
> > > +       pcie0 at 290000 {
> > > +               reset-gpio = <&pin_ctrl 5 0>;
> > > +       };
> > > +
> > > +       pcie1 at 2a0000 {
> > > +               reset-gpio = <&pin_ctrl 22 0>;
> > > +       };
> > > 
> > > arch/arm/boot/dts/exynos5440.dtsi
> > > -       pinctrl {
> > > +       pin_ctrl: pinctrl {
> > 
> > Note that you don't really have to use a label, you can also refer
> > to the pinctrl node by its full path, which is just "/pinctrl"
> > or "/pinctrl at e0000".

Sure, you can, but this is ugly.

> 
> I see.
> 
> But, I have a question.
> Using phandle has been the usual way to referring to a node.
> Why do you want to do it differently?

Path is translated to a phandle as well.

--
Best regards,
Tomasz
