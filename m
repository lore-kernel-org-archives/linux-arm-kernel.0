From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 28 Jan 2013 13:29:46 +0100
Subject: [PATCH] cpufreq: instantiate cpufreq-cpu0 as a platform_driver
In-Reply-To: <20130128083159.GD31689@S2101-09.ap.freescale.net>
References: <1359208550-16402-1-git-send-email-shawn.guo@linaro.org>
 <7196597.b9sJl95POM@vostro.rjw.lan>
 <20130128083159.GD31689@S2101-09.ap.freescale.net>
Message-ID: <13207641.5ODXr2fVG6@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 28, 2013 04:32:01 PM Shawn Guo wrote:
> On Sat, Jan 26, 2013 at 11:21:27PM +0100, Rafael J. Wysocki wrote:
> > On Saturday, January 26, 2013 09:55:50 PM Shawn Guo wrote:
> > > As multiplatform build is being adopted by more and more ARM platforms,
> > > initcall function should be used very carefully.  For example, when
> > > GENERIC_CPUFREQ_CPU0 is built in the kernel, cpu0_cpufreq_driver_init()
> > > will be called on all the platforms to initialize cpufreq-cpu0 driver.
> > > 
> > > To eliminate this undesired the effect, the patch changes cpufreq-cpu0
> > > driver to have it instantiated as a platform_driver.  Then it will only
> > > run on platforms that create the platform_device "cpufreq-cpu0".
> > > 
> > > Along with the change, it also changes cpu_dev to be &pdev->dev,
> > > so that managed functions can start working, and module build gets
> > > supported too.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > ---
> > > Rafael,
> > > 
> > > The patch depends patch "power: export opp cpufreq functions".
> > > https://patchwork.kernel.org/patch/1847261/
> > 
> > That one should use EXPORT_SYMBOL_GPL() for exporting symbols, though.
> > 
> When commit 80126ce (PM / OPP: Export symbols for module usage.)
> already exported a few symbols with EXPORT_SYMBOL()?

Yes, even then.

All symbols in new patches that I apply have to be exported with _GPL.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
