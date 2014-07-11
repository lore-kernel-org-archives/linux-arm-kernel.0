From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Fri, 11 Jul 2014 17:14:10 +0300
Subject: [PATCH 12/13] cpufreq: Add cpufreq driver for Tegra124
In-Reply-To: <CAKohpom9ORXFiUU4=V+CxgN0ZOFLMEhEjHiU8HsYUYDybNXgHQ@mail.gmail.com>
References: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>	<1405028569-14253-13-git-send-email-ttynkkynen@nvidia.com>
 <CAKohpom9ORXFiUU4=V+CxgN0ZOFLMEhEjHiU8HsYUYDybNXgHQ@mail.gmail.com>
Message-ID: <53BFF132.3020700@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/07/14 07:35, Viresh Kumar wrote:
> Hi Tuomas,
>
> On 11 July 2014 03:12, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
>> Add a new cpufreq driver for Tegra124. Instead of using the PLLX as
>> the CPU clocksource, switch immediately to the DFLL. It allows the use
>> of higher clock rates, and will automatically scale the CPU voltage as
>> well. We also rely on the DFLL driver to determine the CPU clock
>> frequencies that the chip supports, so that we can directly build a
>> cpufreq table with the OPP library helper dev_pm_opp_init_cpufreq_table.
>>
>> This driver is a completely independent of the old cpufreq driver
>> (tegra-cpufreq), which is only used on Tegra20.
>>
>> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
>
> Please reuse cpufreq-cpu0 instead of adding a new driver. Similar
> is being adopted by all platforms now: krait, mvebu, etc..
>

Sure, I can do the CPU clock parent change first and then instantiate 
the cpufreq-cpu0 driver, like highbank-cpufreq. That'll depend on the 
patch 'cpufreq: cpu0: OPPs can be populated at runtime' from your 
'Extend support beyond CPU0' series though, any idea when that patch 
will land in?


-- 
nvpublic
