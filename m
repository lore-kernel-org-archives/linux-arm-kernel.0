From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 21 Apr 2016 15:20:32 +0530
Subject: [PATCH 2/8] cpufreq: imx: Use generic platdev driver
In-Reply-To: <18756925.NSB5aJaqC9@wuerfel>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
 <08c7bf360dfb7620591c0e0de6e047fffb0a5546.1461228081.git.viresh.kumar@linaro.org>
 <18756925.NSB5aJaqC9@wuerfel>
Message-ID: <20160421095032.GD29799@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-04-16, 11:46, Arnd Bergmann wrote:
> On Thursday 21 April 2016 14:13:48 Viresh Kumar wrote:
> > The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
> > device now, reuse that and remove similar code from platform code.
> > 
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  arch/arm/mach-imx/imx27-dt.c         | 4 ----
> >  arch/arm/mach-imx/mach-imx51.c       | 3 ---
> >  arch/arm/mach-imx/mach-imx53.c       | 2 --
> >  arch/arm/mach-imx/mach-imx7d.c       | 6 ------
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 5 +++++
> >  5 files changed, 5 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
> > index bd42d1bd10af..90c62bf01f9e 100644
> > --- a/arch/arm/mach-imx/imx27-dt.c
> > +++ b/arch/arm/mach-imx/imx27-dt.c
> > @@ -20,11 +20,7 @@
> >  
> >  static void __init imx27_dt_init(void)
> >  {
> > -	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
> > -
> >  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > -
> > -	platform_device_register_full(&devinfo);
> >  }
> >
> 
> Please remove the entire function now, a NULL .init_machine machine
> callback pointer has the same effect as the remaining line.
> 
> The rest of the patch is fine.

Perhaps that should be done in a separate patch I feel. Will do so after this is
merged.

-- 
viresh
