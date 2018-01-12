From: sean.wang@mediatek.com (Sean Wang)
Date: Fri, 12 Jan 2018 11:33:06 +0800
Subject: [PATCH 05/12] arm64: dts: mt7622: add PMIC MT6380 related nodes
In-Reply-To: <CAOFm3uEkqKGhsziwf6o3i2o0Ua=ah4CHgh-Hr+aC4zHxH3mZzQ@mail.gmail.com>
References: <cover.1515057696.git.sean.wang@mediatek.com>
 <0109846a8a501ca3cae33acfceb919960fddfcbf.1515057696.git.sean.wang@mediatek.com>
 <CAOFm3uF0WHO6_Y6dKu3DnAd759tA2hNQs=0-P86s1A0e==27Ow@mail.gmail.com>
 <1515123759.30687.71.camel@mtkswgap22>
 <CAOFm3uEkqKGhsziwf6o3i2o0Ua=ah4CHgh-Hr+aC4zHxH3mZzQ@mail.gmail.com>
Message-ID: <1515727986.12197.3.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Philippe

Currently, I'm really confused about what usage STYLE of SPDX license
identifier I should use for each type of file. 

could you point me where I can find the related document describing SPDX
usage style for those files expected by the community in the future?

I found more than one way STYLE of SPDX present at current code, for
example as below. If there's no absolute definition for them, and then
which way that is better?

1)

for *.dts, applied with "// " at head or within " /* */ " not at head

such as 

arch/arm/boot/dts/bcm953012hr.dts:2: *  SPDX-License-Identifier:
BSD-3-Clause
arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts:4: *
SPDX-License-Identifier: (GPL-2.0+ OR MIT)
arch/arm/boot/dts/uniphier-ld6b-ref.dts:7: * SPDX-License-Identifier:
(GPL-2.0+ OR MIT)
arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts:4: *
SPDX-License-Identifier: (GPL-2.0+ OR MIT)
arch/arm/boot/dts/keystone-k2g-ice.dts:6: * SPDX-License-Identifier:
GPL-2.0
arch/arm/boot/dts/uniphier-pro4-sanji.dts:7: * SPDX-License-Identifier:
(GPL-2.0+ OR MIT)
arch/arm/boot/dts/owl-s500-cubieboard6.dts:6: * SPDX-License-Identifier:
(GPL-2.0+ OR MIT)
arch/arm/boot/dts/uniphier-pro4-ace.dts:7: * SPDX-License-Identifier:
(GPL-2.0+ OR MIT)
arch/arm/boot/dts/uniphier-sld8-ref.dts:7: * SPDX-License-Identifier:
(GPL-2.0+ OR MIT)
arch/arm/boot/dts/uniphier-pro4-ref.dts:7: * SPDX-License-Identifier:
(GPL-2.0+ OR MIT)
arch/arm/boot/dts/uniphier-pxs2-gentil.dts:7: * SPDX-License-Identifier:
(GPL-2.0+ OR MIT)
arch/arm/boot/dts/uniphier-pxs2-vodka.dts:7: * SPDX-License-Identifier:
(GPL-2.0+ OR MIT)
arch/arm/boot/dts/uniphier-ld4-ref.dts:7: * SPDX-License-Identifier:
(GPL-2.0+ OR MIT)

arch/arm64/boot/dts/nvidia/tegra132-norrin.dts:1://
SPDX-License-Identifier: GPL-2.0
arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts:1://
SPDX-License-Identifier: GPL-2.0
arch/arm64/boot/dts/nvidia/tegra210-smaug.dts:1://
SPDX-License-Identifier: GPL-2.0
arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts:1://
SPDX-License-Identifier: GPL-2.0
arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts:1:// SPDX-License-Identifier:
GPL-2.0
arch/arm64/boot/dts/arm/foundation-v8.dts:1:// SPDX-License-Identifier:
GPL-2.0
arch/arm64/boot/dts/arm/foundation-v8-gicv3.dts:1://
SPDX-License-Identifier: GPL-2.0
arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts:1://
SPDX-License-Identifier: GPL-2.0

2)

for *.c, applied with "// " at head or within " /* */ " not at head

such as

drivers/base/memory.c:1:// SPDX-License-Identifier: GPL-2.0
drivers/base/devtmpfs.c:1:// SPDX-License-Identifier: GPL-2.0
drivers/base/node.c:1:// SPDX-License-Identifier: GPL-2.0
drivers/base/dma-coherent.c:1:// SPDX-License-Identifier: GPL-2.0
drivers/cpuidle/cpuidle-pseries.c:1:// SPDX-License-Identifier: GPL-2.0
drivers/cpuidle/cpuidle-powernv.c:1:// SPDX-License-Identifier: GPL-2.0
drivers/mtd/maps/tsunami_flash.c:1:// SPDX-License-Identifier: GPL-2.0
drivers/mtd/maps/physmap_of_gemini.c:1:// SPDX-License-Identifier:
GPL-2.0
drivers/mtd/tests/mtd_test.c:1:// SPDX-License-Identifier: GPL-2.0
drivers/mtd/onenand/onenand_bbt.c:1:// SPDX-License-Identifier: GPL-2.0
drivers/media/common/b2c2/flexcop-i2c.c:1:// SPDX-License-Identifier:
GPL-2.0

drivers/soc/xilinx/zynqmp/pm.c:10: * SPDX-License-Identifier:   GPL-2.0+
drivers/soc/amlogic/meson-gx-pwrc-vpu.c:5: * SPDX-License-Identifier:
GPL-2.0+
drivers/soc/amlogic/meson-gx-socinfo.c:5: * SPDX-License-Identifier:
GPL-2.0+
drivers/soc/amlogic/meson-mx-socinfo.c:4: * SPDX-License-Identifier:
GPL-2.0+
drivers/i2c/busses/i2c-sprd.c:4: * SPDX-License-Identifier: (GPL-2.0+ OR
MIT)
drivers/spi/spi-meson-spicc.c:7: * SPDX-License-Identifier: GPL-2.0+
drivers/spi/spi-sprd-adi.c:4: * SPDX-License-Identifier: GPL-2.0
drivers/dma/sprd-dma.c:4: * SPDX-License-Identifier: GPL-2.0


3)

for *.h, applied with "// " at head or within " /* */ " at head

such as 

drivers/usb/dwc3/gadget.h:1:// SPDX-License-Identifier: GPL-2.0
drivers/usb/dwc3/io.h:1:// SPDX-License-Identifier: GPL-2.0
drivers/usb/dwc3/debug.h:1:// SPDX-License-Identifier: GPL-2.0
drivers/usb/dwc3/core.h:1:// SPDX-License-Identifier: GPL-2.0
drivers/usb/atm/usbatm.h:1:// SPDX-License-Identifier: GPL-2.0+
drivers/usb/misc/rio500_usb.h:1:// SPDX-License-Identifier: GPL-2.0+
drivers/usb/misc/sisusbvga/sisusb.h:1:// SPDX-License-Identifier:
(GPL-2.0 OR BSD-3-Clause)
drivers/usb/misc/sisusbvga/sisusb_init.h:1:// SPDX-License-Identifier:
(GPL-2.0+ OR BSD-3-Clause)
drivers/usb/misc/sisusbvga/sisusb_struct.h:1:// SPDX-License-Identifier:
(GPL-2.0+ OR BSD-3-Clause)
drivers/usb/misc/usb_u132.h:1:// SPDX-License-Identifier: GPL-2.0

drivers/tty/serial/dz.h:1:/* SPDX-License-Identifier: GPL-2.0 */
drivers/tty/serial/apbuart.h:1:/* SPDX-License-Identifier: GPL-2.0 */
drivers/tty/serial/sunzilog.h:1:/* SPDX-License-Identifier: GPL-2.0 */
drivers/tty/serial/zs.h:1:/* SPDX-License-Identifier: GPL-2.0 */
drivers/tty/serial/sh-sci.h:1:/* SPDX-License-Identifier: GPL-2.0 */
drivers/tty/serial/cpm_uart/cpm_uart_cpm1.h:1:/*
SPDX-License-Identifier: GPL-2.0 */
drivers/tty/serial/cpm_uart/cpm_uart_cpm2.h:1:/*
SPDX-License-Identifier: GPL-2.0 */
drivers/tty/serial/sunsab.h:1:/* SPDX-License-Identifier: GPL-2.0 */
drivers/tty/serial/amba-pl011.h:1:/* SPDX-License-Identifier: GPL-2.0 */
drivers/tty/serial/crisv10.h:1:/* SPDX-License-Identifier: GPL-2.0 */

4)

no issue, Makefile, or Kconfig, definitely applied with "# " at head

	Sean



On Fri, 2018-01-05 at 09:21 +0100, Philippe Ombredanne wrote:
> Sean,
> 
> On Fri, Jan 5, 2018 at 4:42 AM, Sean Wang <sean.wang@mediatek.com> wrote:
> > On Thu, 2018-01-04 at 11:27 +0100, Philippe Ombredanne wrote:
> >> Sean,
> >>
> >> On Thu, Jan 4, 2018 at 10:40 AM,  <sean.wang@mediatek.com> wrote:
> >> > From: Sean Wang <sean.wang@mediatek.com>
> >> >
> >> > Enable pwrap and MT6380 on mt7622-rfb1 board. Also add all mt6380
> >> > regulator nodes in an alone file to allow similar boards using MT6380
> >> > able to resue the configuration.
> >> >
> >> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> >> > Cc: Mark Brown <broonie@kernel.org>
> >> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> >> > ---
> >> >  arch/arm64/boot/dts/mediatek/mt6380.dtsi     | 91 ++++++++++++++++++++++++++++
> >> >  arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts |  8 +++
> >> >  arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 12 ++++
> >> >  3 files changed, 111 insertions(+)
> >> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt6380.dtsi
> >> >
> >> > diff --git a/arch/arm64/boot/dts/mediatek/mt6380.dtsi b/arch/arm64/boot/dts/mediatek/mt6380.dtsi
> >> > new file mode 100644
> >> > index 0000000..7eb7dc2
> >> > --- /dev/null
> >> > +++ b/arch/arm64/boot/dts/mediatek/mt6380.dtsi
> >> > @@ -0,0 +1,91 @@
> >> > +/*
> >> > + * Copyright (c) 2018 MediaTek Inc.
> >> > + * Author: Chenglin Xu <chenglin.xu@mediatek.com>
> >> > + *        Sean Wang <sean.wang@mediatek.com>
> >> > + *
> >> > + * This program is free software; you can redistribute it and/or modify
> >> > + * it under the terms of the GNU General Public License version 2 as
> >> > + * published by the Free Software Foundation.
> >> > + *
> >> > + * This program is distributed in the hope that it will be useful,
> >> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> > + * GNU General Public License for more details.
> >> > + */
> >>
> >> Would you mind using SPDX tags instead of this fine but long legalese?
> >> This is documented in Thomas patches [1].
> >
> >> Also if you could spread the word in your team, this would earn you
> >> good karma points.
> >> Thank you!
> >>
> >> [1] https://lkml.org/lkml/2017/12/28/323
> >
> >
> > Hi, Philippe
> >
> > thanks for your suggestion
> >
> > Certainly, this can be replaced with
> >
> > SPDX-License-Identifier: GPL-2.0
> >
> > most drivers from MediaTek use the similar disclaimer, it should be fine
> > to use SPDX tags instead.
> >
> >         Sean
> >
> 
> Thank you! that's great.
> 
