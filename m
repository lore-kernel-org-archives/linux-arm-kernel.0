From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 17 Jul 2012 09:01:16 +0900
Subject: ARM: s3c2410: remove dead mach-s3c2410 directory
In-Reply-To: <201206251806.28081.heiko@sntech.de>
References: <1340619112.1773.155.camel@x61.thuisdomein>
 <201206251806.28081.heiko@sntech.de>
Message-ID: <144301cd63af$49c53520$dd4f9f60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> Am Montag 25 Juni 2012, 12:11:52 schrieb Paul Bolle:
> > Commit 85fd6d63bf2927b9da7ab1b0d46723bfdb13808c ("ARM: S3C2410: move
> > mach-s3c2410/* into mach-s3c24xx/") orphaned
> > arch/arm/mach-s3c2410/Kconfig: currently no other Kconfig file sources
> > that file. This means that the Kconfig symbols S3C2410_CPUFREQ and
> > S3C2410_PLLTABLE will never be set, which in turns means that the macros
> > CONFIG_S3C2410_CPUFREQ and CONFIG_S3C2410_PLLTABLE will never be
> > defined.
> >
> > All this makes that all four files in the mach-directory (Kconfig,
> > Makefile, cpu-freq.c, and pll.c) are effectively dead files since v3.4:
> > none of them can lead to any code in someones kernel. This directory can
> > safely be removed.
> 
> I don't think so. CPU-frequency-scaling on the earlier S3C architectures
> was
> probably working before the beginning of the directory merge.
> 
Yeah, maybe. But I think, sourcing mach-s3c2410/Kconfig is enough to fix working s3c24xx cpufreq.

> If I recall correctly Kgene was working on completing these missing pieces
> of
> the move to mach-s3c24xx.
> 
Yes, Heiko's memory is correct. But mainly my colleague is working it instead and I'm just helping him. As I know he needs more time probably it's not possible for upcoming merge window but next time, it's ok.

> The reason for noone complaining about the missing cpufreq support yet,
> might
> be that projects using the early S3C architectures hae not made it to the
> most
> recent kernel releases.
> 
Yeah, maybe. Anyway we should fix it as soon as possible...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
