From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 22 Dec 2017 10:16:16 +0530
Subject: [PATCH] arm64: defconfig: Select schedutil as default cpufreq
 governor
In-Reply-To: <CAK8P3a1FinyyFr840-JkTcX2mL8QTtcnvYi3hpczs3Yx_ga-ww@mail.gmail.com>
References: <af12e002bc165844101830c0eb00e283b536a879.1510813288.git.viresh.kumar@linaro.org>
 <20171215155040.mlvd56i2rfgd2e2t@armageddon.cambridge.arm.com>
 <20171218042917.GB19815@vireshk-i7>
 <CAK8P3a1FinyyFr840-JkTcX2mL8QTtcnvYi3hpczs3Yx_ga-ww@mail.gmail.com>
Message-ID: <20171222044616.GC8312@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-12-17, 16:32, Arnd Bergmann wrote:
> On Mon, Dec 18, 2017 at 5:29 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 15-12-17, 15:50, Catalin Marinas wrote:
> >> On Thu, Nov 16, 2017 at 11:51:36AM +0530, Viresh Kumar wrote:
> >> > Currently performance governor is getting selected by default, which is
> >> > surely not a very good choice as its pretty much power hungry.
> >> >
> >> > Select schedutil instead.
> >>
> >> And why do we care about this in defconfig? People deploying their own
> >> kernels in mobile may opt for this config, others may prefer the default
> >> governor.
> >>
> >> Also it seems it would be the only architecture make this governor the
> >> default, so NAK.
> >
> > This is a bit dangerous configuration IMHO.
> >
> > Other architectures have some *real* governor selected by default, like Ondemand
> > or Conservative. Running your CPUs at max (because of the default performance
> > governor in arm64 config) may end up burning some SoCs accidentally just because
> > their thermal stuff doesn't kick in to cool SoC down properly.
> >
> > So, we should have one of ondemand, conservative and schedutil selected by
> > default for arm64 as well IMO and schedutil is the one which every one is
> > falling back to now a days, even android.
> 
> Maybe it's time to change the global 'default
> CPU_FREQ_DEFAULT_GOV_PERFORMANCE' instead to avoid having to
> do this for each architecture separately?
> 
> I think the general idea of using schedutil or ondemand instead of performance
> makes sense, but it doesn't feel right to have to do this for every
> single defconfig
> that doesn't select a default.

+Rafael to see what his views are on this.

-- 
viresh
