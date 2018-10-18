From: sean.wang@kernel.org (Sean Wang)
Date: Thu, 18 Oct 2018 23:06:08 +0800
Subject: [PATCH 5/5] pinctrl: mediatek: Add initial pinctrl driver for
 MT6797 SoC
In-Reply-To: <e7abee72-23a3-4716-baf0-484514bbb019@gmail.com>
References: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
 <20181008191411.32555-6-manivannan.sadhasivam@linaro.org>
 <c8d65395-c60c-5d06-92ad-c389642c22ba@gmail.com>
 <20181011164429.GA18174@Mani-XPS-13-9360>
 <e7abee72-23a3-4716-baf0-484514bbb019@gmail.com>
Message-ID: <CAGp9LzoP2zkryhJCQNGpe9X0+7yUd31ffV7vM4j6KvTdfPpCrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 10:01 PM Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
>
>
> On 11/10/2018 18:44, Manivannan Sadhasivam wrote:
> > On Thu, Oct 11, 2018 at 05:50:19PM +0200, Matthias Brugger wrote:
> >>
> >>
> >> On 08/10/2018 21:14, Manivannan Sadhasivam wrote:
> >>> Add initial pinctrl driver for Mediatek MT6797 SoC supporting only
> >>> GPIO and pinmux configurations.
> >>>
> >>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>> ---
> >>>  drivers/pinctrl/mediatek/Kconfig              |    7 +
> >>>  drivers/pinctrl/mediatek/Makefile             |    1 +
> >>>  drivers/pinctrl/mediatek/pinctrl-mt6797.c     |   82 +
> >>>  drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h | 2430 +++++++++++++++++
> >>>  4 files changed, 2520 insertions(+)
> >>>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6797.c
> >>>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h
> >>>
> >> [...]
> >>> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h
> >>> new file mode 100644
> >>> index 000000000000..8949d2a15c39
> >>> --- /dev/null
> >>> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h
> >>> @@ -0,0 +1,2430 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>> +/*
> >>> + * Based on pinctrl-mtk-mt6765.h
> >>> + *
> >>> + * Copyright (C) 2018 MediaTek Inc.
> >>> + *
> >>> + * Author: ZH Chen <zh.chen@mediatek.com>
> >>> + *
> >>> + * Copyright (c) 2018 Manivannan Sadhasivam
> >>> + */
> >>> +
> >>> +#ifndef __PINCTRL_MTK_MT6797_H
> >>> +#define __PINCTRL_MTK_MT6797_H
> >>> +
> >>> +#include "pinctrl-paris.h"
> >>> +
> >>> +static const struct mtk_pin_desc mtk_pins_mt6797[] = {
> >>> +   MTK_PIN(
> >>> +           0, "GPIO0",
> >>> +           MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
> >>> +           DRV_GRP3,
> >>
> >> As far as I have seen, you put all pins in driving group 3, but from the public
> >> available "Functional Specification" (page 51-81) I can see that there exist
> >> several driving groups:
> >> 2/4/6/8 mA (DRV_GRP3)
> >> 4/8/12/16 mA (not sure which group this is)
> >> 2/4/6/8/10/12/14/16 mA (DRV_GRP4).
> >>
> >
> > Not sure about that. But I derived the configuration from DRV_CFGx
> > registers available in "Application Software Register Table - Part 1"
> > from page no: 906.
> >
> > This register supports 2/4/6/8mA and this belongs to DRV_GRP2/DRV_GRP3
> > [1].
>
> I can see other driving groups as defined in the "Functional Specification" [1]
> which gets also reflected in the "Application Software Register Table - Part 1"
> [2], see for example page 852.
>
> CCing Mars, maybe he can help to clarify.
>

the driver currently only supports the basic operation, not including
driving operation, so
what value for the driving mode for a certain pin seems not really
matter in the early patch. I think these advanced operations can be
added with another patch.

> Regards,
> Matthias
>
> [1]
> https://www.96boards.org/documentation/consumer/mediatekx20/additional-docs/docs/MT6797_Functional_Specification_V1_0.pdf
> [2]
> https://www.96boards.org/documentation/consumer/mediatekx20/additional-docs/docs/MT6797_Register_Table_Part_1.pdf
>
> >
> > Still I'm not fully confident of my choice here. Maybe Sean can throw
> > some inputs!
> >
> > Thanks,
> > Mani
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c#n40
> >
> >> Regards,
> >> Matthias
> >>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
