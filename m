From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 22 Feb 2012 09:22:25 +0900
Subject: [PATCH v3] DMA: PL330: Merge PL330 driver into drivers/dma/
In-Reply-To: <CABb+yY1E0_ZhTv8QvRAfgUvc=2Vz+ioYbsEczknP5dKcL2ZCbw@mail.gmail.com>
References: <1329341243-14314-1-git-send-email-kgene.kim@samsung.com>
 <CABb+yY1E0_ZhTv8QvRAfgUvc=2Vz+ioYbsEczknP5dKcL2ZCbw@mail.gmail.com>
Message-ID: <00f401ccf0f8$0db84ec0$2928ec40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar wrote:
> 
> On Thu, Feb 16, 2012 at 2:57 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > From: Boojin Kim <boojin.kim@samsung.com>
> >
> > Currently there were two part of DMAC PL330 driver for
> > support old styled s3c-pl330 which has been merged into
> > drivers/dma/pl330.c driver. Actually, there is no reason
> > to separate them now.
> >
> > Basically this patch merges arch/arm/common/pl330.c into
> > drivers/dma/pl330.c driver and removes useless exported
> > symbol, externed function and so on.
> >
> > The newer pl330 driver tested on SMDKV310 and SMDK4212 boards
> >
> > Cc: Jassi Brar <jassisinghbrar@gmail.com>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Acked-by: Vinod Koul <vinod.koul@intel.com>
> > Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> > Changes since v2:
> > - Address comments from Russell King
> >  the 'asm/hardware/pl330.h' is moved to 'drivers/dma/pl330.h'
> >  which is used only in drivers/dma/
> >
> >  arch/arm/common/Kconfig               |    3 -
> >  arch/arm/common/Makefile              |    1 -
> >  arch/arm/common/pl330.c               | 1959 ----------------------------
> -----
> >  arch/arm/include/asm/hardware/pl330.h |  217 ----
> >  drivers/dma/Kconfig                   |    1 -
> >  drivers/dma/pl330.c                   | 1892
> +++++++++++++++++++++++++++++++-
> >  drivers/dma/pl330.h                   |  251 +++++
> >  include/linux/amba/pl330.h            |    1 -
> >  8 files changed, 2142 insertions(+), 2183 deletions(-)
> >  delete mode 100644 arch/arm/common/pl330.c
> >  delete mode 100644 arch/arm/include/asm/hardware/pl330.h
> >  create mode 100644 drivers/dma/pl330.h
> >
> I repeat yet again, the drivers/dma/pl330.h is included _only_ by
> drivers/dma/pl330.c so it'll be better to simply move its content
> in the c file and reduce file count by 1.
> 
Hmm, yeah, since the .h file contents is used only by .c file, it would be included in the .c file itself. But I'm not sure, in this case, which one is better.

> 
> > diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> > index b8ec03e..65c5f24 100644
> > --- a/drivers/dma/pl330.c
> > +++ b/drivers/dma/pl330.c
> > @@ -1,4 +1,7 @@
> > -/* linux/drivers/dma/pl330.c
> > +/*
> > + * Copyright (c) 2012 Samsung Electronics Co., Ltd.
> > + *             http://www.samsung.com
> > + * Boojin Kim <boojin.kim@samsung.com>
> >  *
> I object.
> If simply moving the code around grants you share of authorship, then
> every person who contributed even a single actual bug fix or feature
> qualifies
> too.
> Javi Merino from ARM Ltd contributed far more important patches to PL330
> and he never claimed authorship (though I think, if not me, he would have
> done the driver just as well or better).

I don't think so. Boojin Kim has done considerable changes to structure/frame of pl330.c. So adding copyright is fine to me. And since she has been doing these updates on behalf of Samsung, she has added attribution to Samsung also (which you never did while at Samsung). And, I don't think some patches are more important than the other. All patches, simple or complex, help in improving the code. In addition, she did not change the MODULE_AUTHOR.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
