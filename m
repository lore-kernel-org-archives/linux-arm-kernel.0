From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 18 Dec 2017 09:59:17 +0530
Subject: [PATCH] arm64: defconfig: Select schedutil as default cpufreq
 governor
In-Reply-To: <20171215155040.mlvd56i2rfgd2e2t@armageddon.cambridge.arm.com>
References: <af12e002bc165844101830c0eb00e283b536a879.1510813288.git.viresh.kumar@linaro.org>
 <20171215155040.mlvd56i2rfgd2e2t@armageddon.cambridge.arm.com>
Message-ID: <20171218042917.GB19815@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-12-17, 15:50, Catalin Marinas wrote:
> On Thu, Nov 16, 2017 at 11:51:36AM +0530, Viresh Kumar wrote:
> > Currently performance governor is getting selected by default, which is
> > surely not a very good choice as its pretty much power hungry.
> > 
> > Select schedutil instead.
> 
> And why do we care about this in defconfig? People deploying their own
> kernels in mobile may opt for this config, others may prefer the default
> governor.
> 
> Also it seems it would be the only architecture make this governor the
> default, so NAK.

This is a bit dangerous configuration IMHO.

Other architectures have some *real* governor selected by default, like Ondemand
or Conservative. Running your CPUs at max (because of the default performance
governor in arm64 config) may end up burning some SoCs accidentally just because
their thermal stuff doesn't kick in to cool SoC down properly.

So, we should have one of ondemand, conservative and schedutil selected by
default for arm64 as well IMO and schedutil is the one which every one is
falling back to now a days, even android.

-- 
viresh
