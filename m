From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 24 Apr 2017 16:59:06 +0530
Subject: Touchscreen failure with CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
In-Reply-To: <CAOMZO5B4_xrLcWQGF=yRfj-14XQKudzjyr2roGRkzofkHCfuHg@mail.gmail.com>
References: <CAOMZO5BZ8Z8dfwsfuiunNQ_q39_k4QJg7jLPQfaxn+YBsmz2jw@mail.gmail.com>
 <20170424040709.GG26900@vireshk-i7>
 <CAOMZO5B4_xrLcWQGF=yRfj-14XQKudzjyr2roGRkzofkHCfuHg@mail.gmail.com>
Message-ID: <20170424112906.GR26900@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24-04-17, 08:20, Fabio Estevam wrote:
> Here it goes, thanks.
> 
> # grep . /sys/devices/system/cpu/cpufreq/policy0/*
> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0 1 2 3
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq:396000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:996000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:396000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:109036
> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0 1 2 3
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies:396000
> 792000 996000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:ondemand
> performance
> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:396000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:imx6q-cpufreq
> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:996000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:396000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
> 
> # grep . /sys/devices/system/cpu/cpufreq/policy0/stats/*
> grep: /sys/devices/system/cpu/cpufreq/policy0/stats/reset: Permission denied
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:396000 2869
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:792000 76
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:996000 33
> /sys/devices/system/cpu/cpufreq/policy0/stats/total_trans:8

So clearly the system isn't changing the frequency a lot here and you stayed at
the min freq for ever. Please give output of this as well:

grep . /sys/devices/system/cpu/cpufreq/ondemand/*

I am also worried if the interrupts from the touchscreen will be enough to boost
the frequency of the CPU ?

-- 
viresh
