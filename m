From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 19 Jun 2012 17:50:45 +0900
Subject: arch/arm/mach-s3c2410/Kconfig is unsourced
In-Reply-To: <1339322235.30984.35.camel@x61.thuisdomein>
References: <1335090082.1814.27.camel@x61.thuisdomein>
 <4F973FB2.1050004@samsung.com> <1339322235.30984.35.camel@x61.thuisdomein>
Message-ID: <019b01cd4df8$9dbc8ba0$d935a2e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Bolle wrote:
> 
> On Tue, 2012-04-24 at 17:05 -0700, Kukjin Kim wrote:
> > Paul Bolle wrote:
> > > 0) commit 85fd6d63bf2927b9da7ab1b0d46723bfdb13808c ("ARM: S3C2410:
> move
> > > mach-s3c2410/* into mach-s3c24xx/") orphaned
> > > arch/arm/mach-s3c2410/Kconfig: currently nothing sources that file in
> > > Linus' tree.
> > >
> > Oops, you're right.
> >
> > > 1) I haven't looked in depth at this, but this made S3C2410_PLLTABLE
> > > disappear from the build system (ie, arch/arm/mach-s3c2410/pll.c is
> dead
> > > code now). Moreover, this basically turned both "select
> S3C2410_CPUFREQ
> > > if CPU_FREQ_S3C24XX", under "config CPU_S3C2410", and "select
> > > S3C2410_IOTIMING if S3C2410_CPUFREQ", under "config ARCH_BAST", into
> > > nops (both in arch/arm/mach-s3c24xx/Kconfig).
> > >
> > > 2) So to me it seems the move has only been done half: either more
> > > things needs to be moved or those things can be removed entirely. But
> > > perhaps arch/arm/mach-s3c2410/Kconfig should just be sourced again.
> > >
> > Yes, I think, would be better right now, if we could add just sourcing
> > mach-s3c2410/Kconfig but as you said, I need to remove entire mach-s3c24
> > stuff.
> >
> > Thanks for your pointing out and let me fix it.
> 
> I reported this issue just after v3.4-rc4 was released. We're now at
> v3.5-rc2 and arch/arm/mach-s3c2410/Kconfig is still unsourced. I'm
> tempted to submit a clean up patch (though I haven't checked what
> currently can be removed because that Kconfig file is still unsourced).
> But perhaps there's a fix pending in some development branch.
> 
Yeah, I'm working on moving s3c24xx cpufreq into drivers/cpufreq/ and then the arch/arm/mach-s3c2410/ will be removed. But I lost the chance in the last time :( and this will be cleared from v3.6 with my patch.

So I think, your cleanup patch would be nice now.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
