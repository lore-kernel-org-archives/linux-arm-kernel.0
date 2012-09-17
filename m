From: kgene@kernel.org (Kukjin Kim)
Date: Mon, 17 Sep 2012 19:37:19 +0900
Subject: [PATCH V4] ARM: EXYNOS5: Add bus clock and set parent clock for
 FIMD
In-Reply-To: <002001cd94bc$05177bc0$0f467340$%han@samsung.com>
References: <1347892995-17924-1-git-send-email-l.krishna@samsung.com>
 <002001cd94bc$05177bc0$0f467340$%han@samsung.com>
Message-ID: <04f401cd94c0$6a13da10$3e3b8e30$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jingoo Han wrote:
> 
> On Monday, September 17, 2012 11:43 PM Leela Krishna Amudala wrote
> >
> > This patch adds the bus clock for FIMD and changes the device name for
> lcd clock
> > also sets mout_mpll_user as parent clock to fimd
> >
> > Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> 
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> 
In this case, since Leela addressed comments from you, seems it should be
'Reviewed-by'?

> It looks good.
> 
> 
> > ---
> >  arch/arm/mach-exynos/clock-exynos5.c |   35
++++++++++++++++++++++++----
> -----
> >  arch/arm/mach-exynos/clock-exynos5.h |   17 ++++++++++++++++
> >  2 files changed, 42 insertions(+), 10 deletions(-)
> >  create mode 100644 arch/arm/mach-exynos/clock-exynos5.h

[snip]

> >  	clk_set_rate(&exynos5_clk_aclk_acp.clk, 267000000);
> >  	clk_set_rate(&exynos5_clk_pclk_acp.clk, 134000000);
> > +	clk_set_parent(&exynos5_clk_sclk_fimd1.clk,
> > +			&exynos5_clk_mout_mpll_user.clk);

Well, do we _really_ need to set same parent clock for fimd1 here on all of
exynos5? I don't think so.

> >
> >  	for (ptr = 0; ptr < ARRAY_SIZE(exynos5_clksrcs); ptr++)
> >  		s3c_set_clksrc(&exynos5_clksrcs[ptr], true);
> > diff --git a/arch/arm/mach-exynos/clock-exynos5.h b/arch/arm/mach-
> exynos/clock-exynos5.h
> > new file mode 100644
> > index 0000000..6f78f5d
> > --- /dev/null
> > +++ b/arch/arm/mach-exynos/clock-exynos5.h
> > @@ -0,0 +1,17 @@
> > +/*
> > + * Copyright (c) 2012 Samsung Electronics Co., Ltd.
> > + *		http://www.samsung.com
> > + *
> > + * Header file for exynos5 clock support
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > +*/
> > +
> > +#ifndef __ASM_ARCH_EXYNOS5_CLOCK_H
> > +#define __ASM_ARCH_EXYNOS5_CLOCK_H __FILE__
> > +
> > +extern struct clksrc_clk exynos5_clk_sclk_fimd1;
> > +

I don't have any idea why we need this.

Note, the 'clock-exynos4.h' is for supporting common exynos4 and specific
exynos4210 and exynos4x12.

[snip]

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
