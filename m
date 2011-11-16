From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 16 Nov 2011 03:37:53 +0000
Subject: [PATCH 1/1] gpio: gpio-mxs: remove the duplicated micro define
References: <1321350910-8685-1-git-send-email-dong.aisheng@linaro.org>
 <74CDBE0F657A3D45AFBB94109FB122FF1740805DF4@HQMAIL01.nvidia.com>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7722D0FCB@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Dong Aisheng-B29396
> Sent: Wednesday, November 16, 2011 11:31 AM
> To: 'Stephen Warren'; Dong Aisheng; linux-kernel at vger.kernel.org
> Cc: grant.likely at secretlab.ca; arnd at arndb.de; s.hauer at pengutronix.de; Guo
> Shawn-R65073; kernel at pengutronix.de
> Subject: RE: [PATCH 1/1] gpio: gpio-mxs: remove the duplicated micro
> define
> 
>  -----Original Message-----
> > From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
> > owner at vger.kernel.org] On Behalf Of Stephen Warren
> > Sent: Wednesday, November 16, 2011 2:42 AM
> > To: Dong Aisheng; linux-kernel at vger.kernel.org
> > Cc: grant.likely at secretlab.ca; arnd at arndb.de; s.hauer at pengutronix.de;
> > Guo Shawn-R65073; kernel at pengutronix.de
> > Subject: RE: [PATCH 1/1] gpio: gpio-mxs: remove the duplicated micro
> > define
> >
> > Dong Aisheng wrote at Tuesday, November 15, 2011 2:55 AM:
> > ...
> > > diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
> > ...
> > > -#define MXS_SET		0x4
> > > -#define MXS_CLR		0x8
> >
> > If the long-term direction on MXS is to move to gpiolib, won't
> It looks gpio-mxs driver is already using gpiolib.
> 
> > MX_SET_ADDR etc. and the inline functions that use it eventually be
> > removed from mach-mxs/include/mach/mxs.h hence requiring the #define
> > be moved back into the GPIO driver?
> >
> Yes, i agree with you.
> Eventually we will remove using <mach/mxs.h>.
> Thanks for the comments.
> 
Sorry for missing Linux-arm-kernel list. Add it.
BTW, one concern is that if we move defines like #define MXS_SET into driver,
then every drivers wanting to use it will define it respectively which will
cause a little code duplication.
Not sure if people would like it.

Regards
Dong Aisheng
