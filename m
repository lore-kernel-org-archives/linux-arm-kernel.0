From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Mon, 27 Jul 2015 14:13:37 +0000
Subject: [PATCH v6 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <20150727134058.GL12927@tiger>
References: <1437584859-64203-1-git-send-email-shenwei.wang@freescale.com>
 <1437584859-64203-2-git-send-email-shenwei.wang@freescale.com>
 <20150727134058.GL12927@tiger>
Message-ID: <CY1PR0301MB084352861E63DA2DE286CC77838E0@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: 2015?7?27? 8:41
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; tglx at linutronix.de; jason at lakedaemon.net; Huang
> Yongcai-B20788; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v6 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
> sources
> 
> On Wed, Jul 22, 2015 at 12:07:38PM -0500, Shenwei Wang wrote:
> > diff --git a/include/soc/imx/gpcv2.h b/include/soc/imx/gpcv2.h new
> > file mode 100644 index 0000000..73d6e75
> > --- /dev/null
> > +++ b/include/soc/imx/gpcv2.h
> 
> I do not like this header, which couples imx7d irqchip and pm driver so
> much.  Can you please elaborate why we have to have this header?

PM driver does depend on the irqchip driver. It needs some input like enabled irqs and
wakeup irqs to decide which module to be powered off in low power states. I am also
considering if the header file could be removed or not. So far it seems a common place
to define a structure which is used in both drivers is still required.

Thanks,
Shenwei
 


> Shawn
> 
> > @@ -0,0 +1,163 @@
> > +/*
> > + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef __SOC_IMX_GPCV2_H__
> > +#define __SOC_IMX_GPCV2_H__
> > +
> > +
> > +#define IMR_NUM			4
> > +#define GPC_MAX_IRQS            (IMR_NUM * 32)
> > +
> > +#define GPC_LPCR_A7_BSC		0x0
> > +#define GPC_LPCR_M4		0x8
> > +
> > +#define GPC_IMR1_CORE0		0x30
> > +#define GPC_IMR1_CORE1		0x40
> > +
> > +#define GPC_PGC_CPU_MAPPING	0xec
> > +#define GPC_PGC_SCU_TIMING	0x890
> > +
> > +#define BM_LPCR_A7_BSC_IRQ_SRC_A7_WAKEUP	0x70000000
> > +#define BM_LPCR_M4_MASK_DSM_TRIGGER		0x80000000
> > +
> > +
> >
