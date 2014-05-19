From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 20 May 2014 01:19:03 +0200
Subject: [PATCH 3/3] cpufreq: Enable big.LITTLE cpufreq driver on arm64
In-Reply-To: <CAKohpo=4c=eDOMxxFi37mLA7LViJ-P_Rb42Yt5ARa_qgiGU8eg@mail.gmail.com>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <1399653631-4938-3-git-send-email-broonie@kernel.org>
 <CAKohpo=4c=eDOMxxFi37mLA7LViJ-P_Rb42Yt5ARa_qgiGU8eg@mail.gmail.com>
Message-ID: <2437793.vfcRUkFCet@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, May 12, 2014 09:46:01 AM Viresh Kumar wrote:
> On 9 May 2014 22:10, Mark Brown <broonie@kernel.org> wrote:
> > From: Mark Brown <broonie@linaro.org>
> >
> > There are arm64 big.LITTLE systems so enable the big.LITTLE cpufreq driver.
> > While IKS is not available for these systems the driver is still useful
> > since it manages clusters with shared frequencies which is the common case
> > for these systems.
> >
> > Long term combining the cpufreq-cpu0 and big.LITTLE drivers may be a
> > more sensible option but that is substantially more complex especially
> > in the case of IKS.
> 
> Yeah, it was left separately for IKS specially :(
> 
> > Signed-off-by: Mark Brown <broonie@linaro.org>
> > ---
> >  drivers/cpufreq/Kconfig.arm | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index 6e05a1e18e52..6a7dd3e958d5 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -5,7 +5,8 @@
> >  # big LITTLE core layer and glue drivers
> >  config ARM_BIG_LITTLE_CPUFREQ
> >         tristate "Generic ARM big LITTLE CPUfreq driver"
> > -       depends on ARM && BIG_LITTLE && ARM_CPU_TOPOLOGY && HAVE_CLK
> > +       depends on (BIG_LITTLE && ARM_CPU_TOPOLOGY) || (ARM64 && SMP)
> > +       depends on HAVE_CLK
> >         select PM_OPP
> >         help
> >           This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

I've queued this one up for 3.16, thanks!

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
