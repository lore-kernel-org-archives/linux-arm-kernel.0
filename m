From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 May 2017 08:38:43 +0200
Subject: [linux-sunxi] [PATCH 1/3] ARM: dts: sun7i-a20: Rename bananapi
 as bananapi m1
In-Reply-To: <20170530062244.GA1962@excalibur.cnev.de>
References: <1496086228-2806-1-git-send-email-jagan@openedev.com>
 <20170529214551.GA1990@excalibur.cnev.de>
 <CAD6G_RQpazcTEBijCzrqSx+7juVajn4as=x1+T-kX8WbKX-jJw@mail.gmail.com>
 <20170530062244.GA1962@excalibur.cnev.de>
Message-ID: <20170530063843.yujrog2ctjkatnlk@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 30, 2017 at 08:22:44AM +0200, Karsten Merker wrote:
> On Tue, May 30, 2017 at 10:00:49AM +0530, Jagan Teki wrote:
> > On Tue, May 30, 2017 at 3:15 AM, Karsten Merker <merker@debian.org> wrote:
> > > On Mon, May 29, 2017 at 07:30:26PM +0000, Jagan Teki wrote:
> > >> From: Jagan Teki <jagan@amarulasolutions.com>
> > >>
> > >> from BPI(BIPAI KEJI LIMITED) products the Bananapi board
> > >> is named as 'Bananapi M1' and this is the starting
> > >> bananapi board from M1 series.
> > >>
> > >> So rename dts and suffix 'M1' on model for the same,
> > >> so-that next sequence on bananapi starts like M1 Plus, M2 and so..on
> > >>
> > >> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > >> ---
> > >> Note: Bananapi BPI product site
> > >> http://www.banana-pi.org/product.html
> > >>
> > >>  arch/arm/boot/dts/Makefile                  |   2 +-
> > >>  arch/arm/boot/dts/sun7i-a20-bananapi-m1.dts | 286 ++++++++++++++++++++++++++++
> > >>  arch/arm/boot/dts/sun7i-a20-bananapi.dts    | 286 ----------------------------
> > >>  3 files changed, 287 insertions(+), 287 deletions(-)
> > >>  create mode 100644 arch/arm/boot/dts/sun7i-a20-bananapi-m1.dts
> > >>  delete mode 100644 arch/arm/boot/dts/sun7i-a20-bananapi.dts
> > >>
> > >> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > >> index 45c6e65..1b086f0 100644
> > >> --- a/arch/arm/boot/dts/Makefile
> > >> +++ b/arch/arm/boot/dts/Makefile
> > >> @@ -851,7 +851,7 @@ dtb-$(CONFIG_MACH_SUN6I) += \
> > >>       sun6i-a31s-sinovoip-bpi-m2.dtb \
> > >>       sun6i-a31s-yones-toptech-bs1078-v2.dtb
> > >>  dtb-$(CONFIG_MACH_SUN7I) += \
> > >> -     sun7i-a20-bananapi.dtb \
> > >> +     sun7i-a20-bananapi-m1.dtb \
> > >>       sun7i-a20-bananapi-m1-plus.dtb \
> > >>       sun7i-a20-bananapro.dtb \
> > >>       sun7i-a20-cubieboard2.dtb \
> > >> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1.dts
> > >> new file mode 100644
> > >> index 0000000..8b97b89
> > >> --- /dev/null
> > >> +++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1.dts
> > >> @@ -0,0 +1,286 @@
> > >> +/*
> > >> + * Copyright 2014 Hans de Goede <hdegoede@redhat.com>
> > >> + *
> > >> + * Hans de Goede <hdegoede@redhat.com>
> > > [...]
> > >> +/dts-v1/;
> > >> +#include "sun7i-a20.dtsi"
> > >> +#include "sunxi-common-regulators.dtsi"
> > >> +
> > >> +#include <dt-bindings/gpio/gpio.h>
> > >> +#include <dt-bindings/interrupt-controller/irq.h>
> > >> +
> > >> +/ {
> > >> +     model = "LeMaker Banana Pi M1";
> > >> +     compatible = "lemaker,bananapi", "allwinner,sun7i-a20";
> > > [...]
> > >> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> > >> deleted file mode 100644
> > >> index ed2f35a..0000000
> > >> --- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> > >> +++ /dev/null
> > >
> > > NACK!
> > >
> > > Please neither rename the dts nor change the model string. Such a
> > > change would make newer kernels unusable on many existing
> > > installations without manual fixups by the end user.  Linux
> > > distributions use databases with model-specific setup information
> > > (such as the dtb file name, the platform-specific bootscript to
> > > use, usable kernel flavours (lpae or non-lpae), etc.) on kernel
> > > installations and kernel upgrades, and those use the model string
> > > as their key for finding the relevant information.  If you change
> > > either the dts file name or the model string inside the dts,
> > > you'll effectively break the proper installation of newer kernel
> > > versions on existing end user systems.
> > 
> > I understand your concerns about distribution change, but with new
> > change in 'bananapi' brand owned by BIPAI KEJI(BPI) the model must
> > need to update and this is not technically as Bananapi board it is
> > Bananapi  M1 [1]
> > 
> > These are generic changes based on the hardware vendor info.
> > 
> > [1] http://www.banana-pi.org/m1.html
> 
> Hello Jagan,
> 
> I have to disagree here. Whatever BIPAI KEJI(BPI) chooses to name
> their products today or in the future doesn't change history. 
> The "original" Banana Pi was sold under the LeMaker brand and it
> was named "Banana Pi" and not "Banana Pi M1".  The fact that
> LeMaker has stopped selling their Banana Pi board and BIPAI
> KEJI(BPI) (a different company than LeMaker!) now sells a board
> that is compatible to the original "LeMaker Banana Pi" under the
> name "Banana Pi M1" (and not "LeMaker Banana Pi M1" as you claim
> in your modified dts) doesn't matter at all for an existing dts
> and is in no way a valid reason to make an incompatible change
> that breaks existing systems.
> 
> If you wanted to add a new (technically identical) dts with a
> different model string under a new dts file name and keep the
> existing one unchanged, I would find that unneccessary but at
> least acceptable insofar as it wouldn't break existing end user
> systems, but breaking existing systems in the wild is clearly
> unacceptable.  I assume that the kernel dts maintainers would
> probably still object to such an addition as it is unneccessary
> from a purely technical point of view if the boards are 100%
> compatible, but that would of course be their decision to make.

I fully agree, we shouldn't have to modify either the DT itself, the
compatibles, or anything really, to keep up with the crazy naming
scheme some random vendor invents.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170530/c88cb1e6/attachment.sig>
