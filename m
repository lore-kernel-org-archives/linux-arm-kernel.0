From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 29 Aug 2013 15:45:58 +0530
Subject: [Query] CPUFreq: Does these machines have separate clock domains for
 CPUs?
Message-ID: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have been doing some CPUFreq cleanup work and
wanted to know if the below mentioned machines have separate
clock domains for their CPUs or all share the same domain?

So, that we can use some generic routines for these drivers which
would eventually do:

cpumask_setall(policy->cpus);

And I wanted to make sure that this doesn't break them.. :)

......

The drivers are:

drivers/cpufreq/at32ap-cpufreq.c
drivers/cpufreq/blackfin-cpufreq.c
drivers/cpufreq/cris-artpec3-cpufreq.c
drivers/cpufreq/cris-etraxfs-cpufreq.c
drivers/cpufreq/davinci-cpufreq.c
drivers/cpufreq/e_powersaver.c
drivers/cpufreq/elanfreq.c
drivers/cpufreq/longhaul.c
drivers/cpufreq/loongson2_cpufreq.c
drivers/cpufreq/pmac32-cpufreq.c
drivers/cpufreq/powernow-k6.c
drivers/cpufreq/powernow-k7.c
drivers/cpufreq/pxa2xx-cpufreq.c
drivers/cpufreq/pxa3xx-cpufreq.c
drivers/cpufreq/sc520_freq.c
drivers/cpufreq/sh-cpufreq.c
drivers/cpufreq/sparc-us2e-cpufreq.c
drivers/cpufreq/sparc-us3-cpufreq.c

--
Viresh
