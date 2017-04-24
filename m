From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 24 Apr 2017 17:13:43 +0530
Subject: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
In-Reply-To: <CAOMZO5BpAsJAKv-p=WPevUnx71fxbLtunJe-0ijVT7T9m7AMSQ@mail.gmail.com>
References: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
 <20170424040709.GG26900@vireshk-i7>
 <CAOMZO5B4_xrLcWQGF=yRfj-14XQKudzjyr2roGRkzofkHCfuHg@mail.gmail.com>
 <20170424112906.GR26900@vireshk-i7>
 <CAOMZO5BpAsJAKv-p=WPevUnx71fxbLtunJe-0ijVT7T9m7AMSQ@mail.gmail.com>
Message-ID: <20170424114343.GS26900@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24-04-17, 08:37, Fabio Estevam wrote:
> On Mon, Apr 24, 2017 at 8:29 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > So clearly the system isn't changing the frequency a lot here and you stayed at
> > the min freq for ever. Please give output of this as well:
> >
> > grep . /sys/devices/system/cpu/cpufreq/ondemand/*
> 
> #  grep . /sys/devices/system/cpu/cpufreq/ondemand/*
> /sys/devices/system/cpu/cpufreq/ondemand/ignore_nice_load:0
> /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy:0
> /sys/devices/system/cpu/cpufreq/ondemand/min_sampling_rate:10000
> /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias:0
> /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor:1
> /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate:109000

110 ms is your sampling rate right now. Looks too high.

Try doing this:

echo 10000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate

and retry your tests.

> /sys/devices/system/cpu/cpufreq/ondemand/up_threshold:95
> 
> > I am also worried if the interrupts from the touchscreen will be enough to boost
> > the frequency of the CPU ?
> 
> It does not seem that the interrupts from the touchscreen boost the
> frequency of the CPU.
> 
> When I keep touching the panel, the CPU frequency stays at 396 MHz.
> 
> Thanks

-- 
viresh
