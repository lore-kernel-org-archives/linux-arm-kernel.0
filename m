From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 4 Mar 2012 20:39:14 +0000
Subject: [PATCH v3 07/10] arm/tegra: Add PWFM controller device tree
 probing
In-Reply-To: <20120303225404.GC6661@avionic-0098.mockup.avionic-design.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF1E67@HQMAIL01.nvidia.com>
 <20120303225404.GC6661@avionic-0098.mockup.avionic-design.de>
Message-ID: <201203042039.14848.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 03 March 2012, Thierry Reding wrote:
> Not enough information to check signature validity.  Show Details
>   * Stephen Warren wrote:
> > Thierry Reding wrote at Wednesday, February 22, 2012 8:17 AM:
> > > Add auxdata to instantiate a device tree for the PWFM controller and
> > > include a corresponding node in the device tree.
> > 
> > > diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> > 
> > > +   pwm: pwm at 7000a000 {
> > > +           compatible = "nvidia,tegra20-pwm";
> > > +           reg = <0x7000a000 0x100>;
> > > +           #pwm-cells = <2>;
> > > +   };
> > 
> > The compatible value probably should list both Tegra30 and Tegra20, so
> > we can know exactly which HW is present, just in case we need to turn
> > on some bug-fix only for one of the variants:
> > 
> >     compatible = "nvidia,tegra30-pwm", "nvidia,tegra20-pwm";
> 
> I'm confused. If I know exactly that the hardware is Tegra30 (which it
> definitely should be if I include tegra30.dtsi), then why list "tegra20-pwm"
> as compatible?
> 
> Or did you mean to list tegra30-pwm as compatible value in the PWM driver?

We generally list the oldest version of the device that a specific version
is compatible to, in order to use the same driver unmodified.

E.g. an ns16550a serial port would list both ns16550a and i8250 in its
compatible fields so it works with operating systems that only know about
i8250.

It's not actually all that useful when you add device tree support for
two versions of the same device at the same time, but I think that
it's good style anyway, in particular when you consider other users of
the device tree data besides the Linux kernel.

	Arnd
