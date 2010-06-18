From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 18 Jun 2010 09:39:17 -0400 (EDT)
Subject: Several questions regarding ARCH_S3C2410
In-Reply-To: <AANLkTin8g1jSGvju_-7rctjw0PTuunSKDivS1_yxp_lS@mail.gmail.com>
References: <AANLkTimPk6mtyB57jXuAq1ugQseS655OCPEuP9-qZYoT@mail.gmail.com>
	<20100618090010.GX3498@trinity.fluff.org>
	<AANLkTin8g1jSGvju_-7rctjw0PTuunSKDivS1_yxp_lS@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1006180937280.13427@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Jun 2010, Eric Miao wrote:

> On Fri, Jun 18, 2010 at 5:00 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> > On Fri, Jun 18, 2010 at 11:43:37AM +0800, Eric Miao wrote:
> >> Hi Ben,
> >>
> >> While working towards a unified kernel, I found that ARCH_S3C2410 actually
> >> includes multiple mach-* already.
> >>
> >> linux-2.6$ git grep "ARCH_S3C2410" arch/arm/Makefile
> >> arch/arm/Makefile:machine-$(CONFIG_ARCH_S3C2410) ? ? ?:= s3c2410 s3c2400
> >> s3c2412 s3c2416 s3c2440 s3c2443
> >>
> >> There are several questions though:
> >>
> >> 1. It looks like only s3c2410 is significant, so all the common definitions
> >> ? ?like PHYS_OFFSET are actually same across all mach-s3c24* (except for
> >> ? ?s3c24a0) ? Yet I've found arch/arm/mach-s3c2400/include/mach/memory.h,
> >> ? ?where a different PHYS_OFFSET is defined, just feel a bit confused.
> >
> > You can safely ignore the s3c24a0 for the moment, there's no-one interested
> > in actually getting it submitted.
> 
> Grrr... indeed.Looking into mach-s3c24a0, it's almost empty except for some
> header files.

What about simply removing that useless stuff from the tree then?

It could always be retrieved from the Git history if someone wants to 
revive it.


Nicolas
