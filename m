From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 22 Jul 2010 10:25:44 +0200
Subject: [PATCH v3] Samsung: sdhci-s3c: add support for new card detection
	methods
In-Reply-To: <20100721161133.5c3285d3.akpm@linux-foundation.org>
References: <1279181721-23333-1-git-send-email-m.szyprowski@samsung.com>
	<20100715133954.7fcb797a.akpm@linux-foundation.org>
	<011401cb24af$8eb2cb70$ac186250$%szyprowski@samsung.com>
	<20100721161133.5c3285d3.akpm@linux-foundation.org>
Message-ID: <000501cb2977$7d6cf210$7846d630$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, July 22, 2010 1:12 AM 

> On Fri, 16 Jul 2010 08:24:26 +0200
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> 
> > > >  arch/arm/mach-s3c64xx/setup-sdhci-gpio.c   |   14 +++++++++---
> > > >  arch/arm/mach-s5pc100/setup-sdhci-gpio.c   |   21 ++++++++++++++----
> -
> > > >  arch/arm/mach-s5pv210/setup-sdhci-gpio.c   |   22 +++++++++++++++---
> --
> > > >  arch/arm/plat-samsung/dev-hsmmc.c          |    5 ++++
> > > >  arch/arm/plat-samsung/dev-hsmmc1.c         |    5 ++++
> > > >  arch/arm/plat-samsung/dev-hsmmc2.c         |    5 ++++
> > > >  arch/arm/plat-samsung/dev-hsmmc3.c         |    5 ++++
> > > >  arch/arm/plat-samsung/include/plat/sdhci.h |   29
> > > ++++++++++++++++++++++++++++
> > > >  8 files changed, 90 insertions(+), 16 deletions(-)
> > >
> > > This is quite confusing.  You've already sent a patch called
> > > "sdhci-s3c: add support for new card detection methods".  It had the
> > > same changelog as this patch and the same title, but the two patches
> > > are utterly different!
> >
> > The real patch has been split into two for easier merging: 1. the driver
> > part and 2. samsung platform related part. The part which patch belongs
> > to is indicated in the last line of the change log.
> >
> > I'm really confused how to submit properly a patch that requires changes
> > to both the driver (which is merged by the proper driver maintainer's
> > sub-tree) and the platform (which should go through platform maintainer's
> > tree).
> 
> Make the relationship very very clear in the changelog.  Send both
> patches to both maintainers.  Ask that one of them merge both patches
> and that the other ack both patches.

Ok. Thanks for the hint.

> Anyway, I've forgotten what's happening here.  I appear to be sitting on
> 
> sdhci-s3c-add-support-for-the-non-standard-minimal-clock-value.patch

This one is independent from the card-detection patches and can be applied
directly onto linux-next kernel tree.

> and
> sdhci-s3c-add-support-for-new-card-detection-methods.patch
> 
> the latter of which is below.
> 
> Am I missing something?  Is
> sdhci-s3c-add-support-for-new-card-detection-methods.patch up to date?
> 

Ok, I will repost these 2 patches under new names to avoid further
confusion. Currently there exists two 
"sdhci-s3c-add-support-for-new-card-detection-methods.patch", both of them 
are required.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
