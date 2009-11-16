From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 16 Nov 2009 09:14:05 +0100
Subject: [PATCH 09/18] ARM: S3C: Prepare s3c64xx-specific s3c-fb	register
	definition for reuse
In-Reply-To: <20091113233231.GQ4808@trinity.fluff.org>
References: <1258014122-18185-1-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-2-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-3-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-4-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-5-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-6-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-7-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-8-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-9-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-10-git-send-email-m.szyprowski@samsung.com>
	<20091113233231.GQ4808@trinity.fluff.org>
Message-ID: <000101ca6694$c6a62290$53f267b0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On November 14, 2009 12:33 AM Ben Dooks wrote:

> On Thu, Nov 12, 2009 at 09:21:53AM +0100, Marek Szyprowski wrote:
> > S5PC1xx Samsung SOC series has very similar frame buffer hardware, so a lot
> > of the code can be shared. Moved s3c64xx-specific s3c-fb register
> > definitions from mach-s3c6400 to common platform directory as regs-fb-v4.h.
> > The new v4 file will be common for S3C6400, S3C6410, S5PC100 and possibly
> > others. Some s3c64xx series specific defines (palette handling) were left
> > in s3c-6400/mach/regs-fb.h, because it is handled differently in S5PC1xx
> > series.
> >
> > Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  arch/arm/mach-s3c6400/include/mach/regs-fb.h |  236 +-------------------------
> >  arch/arm/plat-s3c/include/plat/regs-fb-v4.h  |  235 +++++++++++++++++++++++++
> >  2 files changed, 244 insertions(+), 227 deletions(-)
> >  create mode 100644 arch/arm/plat-s3c/include/plat/regs-fb-v4.h
> >
> > diff --git a/arch/arm/mach-s3c6400/include/mach/regs-fb.h b/arch/arm/mach-s3c6400/include/mach/regs-
> fb.h
> > index 4701979..5fbc0d7 100644
> > --- a/arch/arm/mach-s3c6400/include/mach/regs-fb.h
> > +++ b/arch/arm/mach-s3c6400/include/mach/regs-fb.h
> > @@ -1,195 +1,30 @@
> > -/* arch/arm/mach-s3c6400/include/mach/regs-fb.h
> > - *
> > +/*
> >   * Copyright 2008 Openmoko, Inc.
> >   * Copyright 2008 Simtec Electronics
> > - *      http://armlinux.simtec.co.uk/
> > - *      Ben Dooks <ben@simtec.co.uk>
> > - *
> > - * S3C64XX - new-style framebuffer register definitions
> > + * Copyright 2009 Samsung Electronics Co.
> 
> I'm not sure what you are trying to do here, it looks like a file
> rename but leaving fragments of the original file?

Yes. All registers that are common for S3C64XX and S5PC100 series were moved to
plat/regs-fb-v4.h. Some registers that are specific for S3C64XX series (mainly
palette registers) were left in mach-s3c6400/include/mach/regs-fb.h. I will resend
this patch with git format-patch -C option enable, so it will be a bit easier to
track what has been changed.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
