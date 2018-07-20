From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 20 Jul 2018 19:19:30 +0200
Subject: [PATCH v2 5/5] ARM64: dts: meson-gxl: add support for the Oranth
 Tanix TX3 Mini
In-Reply-To: <0c92a375-d764-2fcc-c339-7bf33534b9f1@baylibre.com>
References: <20180714193725.17837-1-martin.blumenstingl@googlemail.com>
 <20180714193725.17837-6-martin.blumenstingl@googlemail.com>
 <0c92a375-d764-2fcc-c339-7bf33534b9f1@baylibre.com>
Message-ID: <CAFBinCBfXvSVkt7k-hxwaHhjDo0jdsVWFvqhBDWkwrKjfZ94pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 10:29 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 14/07/2018 21:37, Martin Blumenstingl wrote:
> > The Tanix TX3 Mini is a TV box based on the Amlogic S905W chipset.
> > There are two variants:
> > - 1 GiB or 2 GiB of DDR3 memory
> > - 8 GB or 16 GB eMMC flash
> >
> > Both variants come with:
> > - 802.11 b/g/n wifi (Silicon Valley Microelectronics SSV6051, does not
> >   support Bluetooth)
> > - an LED 7 segment display with an FD628 controller
> > - HDMI and AV (CVBS) output
> > - 2x USB (utilizing both USB ports provided by the SoC)
> > - micro SD card slot
> > - serial console (uart_AO) has to be soldered after opening the case
>
> So it's 10/100 ethernet ? Only to confirm !
yes, 10/100 Ethernet (using the internal PHY) is available as well

> >
> > The board seems to be very similar to the P23x and Q20x reference
> > boards, which is why it includes meson-gx-p23x-q20x.dtsi:
> > - eMMC reset routed to BOOT_9
> > - the SDIO wifi chip's reset line is routed to GPIOX_6 and the reference
> >   clock is 32.768KHz on PWM_E
> > - SD card detection is routed to CARD_6
> > - vqmmc of all MMC controllers is hard-wired to 1.8V (VDDIO_BOOT)
> > - uart_AO can be accessed after opening the case and soldering RX, TX
> >   and GND lines onto the exposed solder points (marked with RX, TX and
> >   GND)
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/Makefile          |  1 +
> >  .../dts/amlogic/meson-gxl-s905w-tx3-mini.dts  | 22 +++++++++++++++++++
> >  2 files changed, 23 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> > index e55156dec237..a97c0e2d7bc6 100644
> > --- a/arch/arm64/boot/dts/amlogic/Makefile
> > +++ b/arch/arm64/boot/dts/amlogic/Makefile
> > @@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
> >  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
> >  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-p241.dtb
> >  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
> > +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-tx3-mini.dtb
> >  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-khadas-vim2.dtb
> >  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
> >  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q200.dtb
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts
> > new file mode 100644
> > index 000000000000..789c819c99c4
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts
> > @@ -0,0 +1,22 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2018 Martin Blumenstingl <martin.blumenstingl@googlemail.com>.
> > + * Based on meson-gxl-s905d-p231.dts:
> > + * - Copyright (c) 2016 Endless Computers, Inc.
> > + *   Author: Carlo Caione <carlo@endlessm.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "meson-gxl-s905x.dtsi"
> > +#include "meson-gx-p23x-q20x.dtsi"
> > +
> > +/ {
> > +     compatible = "oranth,tx3-mini", "amlogic,s905w", "amlogic,meson-gxl";
> > +     model = "Oranth Tanix TX3 Mini";
> > +
> > +     memory at 0 {
> > +             device_type = "memory";
> > +             reg = <0x0 0x0 0x0 0x40000000>; /* 1 GiB or 2 GiB */
> > +     };
> > +};
> >
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
thank you for reviewing the whole series!


Regards
Martin
