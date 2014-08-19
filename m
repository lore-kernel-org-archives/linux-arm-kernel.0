From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 19 Aug 2014 11:57:22 +0200
Subject: [PATCH 1/2] ARM: dts: Enable PMIC interrupts on ODROID
In-Reply-To: <53F22D1B.4010900@samsung.com>
References: <1405500606-5752-1-git-send-email-drake@endlessm.com>
 <CAAObsKAokjDmpVy5cm_iFD52bCq+3jYeGDWzACsmh-JKktyjDw@mail.gmail.com>
 <53F22D1B.4010900@samsung.com>
Message-ID: <3413299.OcpyWkc82q@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, August 18, 2014 11:43:07 AM Kukjin Kim wrote:
> On 08/12/14 08:06, Tomeu Vizoso wrote:
> > Tested on an Odroid-U2:
> >
> > Tested-by: Tomeu Vizoso<tomeu@tomeuvizoso.net>
> >
> > Thanks,
> >
> > Tomeu
> >
> >
> > On 16 July 2014 10:50, Daniel Drake<drake@endlessm.com>  wrote:
> >> The ODROID kernel shows that the PMIC interrupt line is hooked up
> >> to pin GPX3-2.
> >>
> >> This is needed for the max77686-irq driver to create the PMIC IRQ
> >> domain, which is needed by max77686-rtc.
> >>
> >> Signed-off-by: Daniel Drake<drake@endlessm.com>
> >> ---
> >>   arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> >> index 6d6d23c..cb6f55f 100644
> >> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> >> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> >> @@ -148,6 +148,10 @@
> >>
> >>                  max77686: pmic at 09 {
> >>                          compatible = "maxim,max77686";
> >> +                       interrupt-parent =<&gpx3>;
> >> +                       interrupts =<2 0>;
> >> +                       pinctrl-names = "default";
> >> +                       pinctrl-0 =<&max77686_irq>;
> >>                          reg =<0x09>;
> >>                          #clock-cells =<1>;
> >>
> >> @@ -368,4 +372,11 @@
> >>                  samsung,pins = "gpx1-3";
> >>                  samsung,pin-pud =<0>;
> >>          };
> >> +
> >> +       max77686_irq: max77686-irq {
> >> +               samsung,pins = "gpx3-2";
> >> +               samsung,pin-function =<0>;
> >> +               samsung,pin-pud =<0>;
> >> +               samsung,pin-drv =<0>;
> >> +       };
> >>   };
> 
> Thanks, applied this series.

Unfortunately these patches were applied to v3.18-next/dt-samsung
branch and not v3.17-samsung-fixes-1 one.

IMHO they should go to upstream ASAP as they fix the boot for
ODROID boards and they cannot break anything as they are limited
to ODROID dts files.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
