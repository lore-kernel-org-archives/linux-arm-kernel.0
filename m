From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 15 Mar 2011 21:04:36 +0900
Subject: [PATCH] ARM: S3C64XX: Fix section mismatch from cpufreq init
References: <1299769093-14516-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <010e01cbe309$29e73460$7db59d20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Mark Brown wrote:
> >
> > The cpufreq init function is referenced from the driver structure and
> > we don't appear to have annotations which allow us to mark that it'll
> > never be called after system init, causing the linker consistency
> > infrastructure to complain. Just remove the __init annotation to avoid
> > noise from the build.
> >
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > ---
> >  arch/arm/mach-s3c64xx/cpufreq.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-s3c64xx/cpufreq.c b/arch/arm/mach-
> > s3c64xx/cpufreq.c
> > index 74c0e83..4375b97 100644
> > --- a/arch/arm/mach-s3c64xx/cpufreq.c
> > +++ b/arch/arm/mach-s3c64xx/cpufreq.c
> > @@ -181,7 +181,7 @@ static void __init
> s3c64xx_cpufreq_config_regulator(void)
> >  }
> >  #endif
> >
> > -static int __init s3c64xx_cpufreq_driver_init(struct cpufreq_policy
> *policy)
> > +static int s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
> >  {
> >  	int ret;
> >  	struct cpufreq_frequency_table *freq;
> > --
> 
> Looks ok, applied into s5p-fixes-for-linus for 38 :)
> Thanks.
> 
Oops, I missed 'pull request' before 38 :(
So will apply this into for-next...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
