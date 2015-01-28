From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 28 Jan 2015 12:48:52 +0200
Subject: [PATCH v3 3/4] ARM: digicolor: add minimal device tree description
In-Reply-To: <20150127230141.GA11263@quad.lixom.net>
References: <cover.1421219953.git.baruch@tkos.co.il>
 <474d0849bb30ab4ec323fa4c1bc67b30b31d3884.1421219953.git.baruch@tkos.co.il>
 <20150127230141.GA11263@quad.lixom.net>
Message-ID: <20150128104852.GE14175@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Tue, Jan 27, 2015 at 03:01:41PM -0800, Olof Johansson wrote:
> On Wed, Jan 14, 2015 at 10:40:32AM +0200, Baruch Siach wrote:
> > cx92755.dtsi describes CX92755 on chip peripherals. conexant_equinox.dts
> > describes the Equinox evaluation board for the CX92755 SoC.
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > ---
> >  arch/arm/boot/dts/Makefile             |   1 +
> >  arch/arm/boot/dts/conexant_equinox.dts |  74 +++++++++++++++++++++++
> >  arch/arm/boot/dts/cx92755.dtsi         | 107 +++++++++++++++++++++++++++++++++
> >  3 files changed, 182 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/conexant_equinox.dts
> >  create mode 100644 arch/arm/boot/dts/cx92755.dtsi
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 91bd5bd62857..fbeb65eaddda 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -75,6 +75,7 @@ dtb-$(CONFIG_ARCH_BRCMSTB) += \
> >  	bcm7445-bcm97445svmb.dtb
> >  dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
> >  	da850-evm.dtb
> > +dtb-$(CONFIG_ARCH_DIGICOLOR) += conexant_equinox.dtb
> >  dtb-$(CONFIG_ARCH_EFM32) += efm32gg-dk3750.dtb
> >  dtb-$(CONFIG_ARCH_EXYNOS) += exynos3250-monk.dtb \
> >  	exynos3250-rinato.dtb \
> > diff --git a/arch/arm/boot/dts/conexant_equinox.dts b/arch/arm/boot/dts/conexant_equinox.dts
> > new file mode 100644
> > index 000000000000..f33bf5635d47
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/conexant_equinox.dts
> 
> To segment the namespace a bit, we ask that you prefix your dts files with the
> platform. What would be a suitable prefix here? conexant? digicolor?

I think we should use the actual SoC name, that is cx92755, just like the 
.dtsi file is named. I'll resend this patch with the name change and a few 
more incremental changes needed by the interrupt controller and timer drivers.

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
