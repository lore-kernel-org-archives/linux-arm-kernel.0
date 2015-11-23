From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 24 Nov 2015 00:21:37 +0100
Subject: [PATCH v2] cpufreq: scpi: Depend on SCPI clk driver
In-Reply-To: <20151118140504.GI7336@ubuntu>
References: <1447854764-9865-1-git-send-email-punit.agrawal@arm.com>
 <20151118140504.GI7336@ubuntu>
Message-ID: <6612767.ybC73pWovO@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 18, 2015 07:35:04 PM Viresh Kumar wrote:
> On 18-11-15, 13:52, Punit Agrawal wrote:
> > The SCPI clk driver registers the virtual cpufreq device that kicks off
> > initialisation of the SCPI cpufreq driver. Also, clk_get() will fail for
> > the cpufreq driver if the scpi clk driver is missing.
> > 
> > Fix this by making the scpi cpufreq driver explicitly depend on the scpi
> > clk driver.
> > 
> > Fixes: 8def31034d03 ("cpufreq: arm_big_little: add SCPI interface driver")
> > Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/Kconfig.arm | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index 1582c1c..dadfdd4 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -201,7 +201,7 @@ config ARM_SA1110_CPUFREQ
> >  
> >  config ARM_SCPI_CPUFREQ
> >          tristate "SCPI based CPUfreq driver"
> > -	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL
> > +	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
> >          help
> >  	  This adds the CPUfreq driver support for ARM big.LITTLE platforms
> >  	  using SCPI protocol for CPU power management.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

Rafael
