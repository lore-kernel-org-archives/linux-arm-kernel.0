From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2012 14:52:31 -0800
Subject: tegra3 vSMP cpu hotplug and LP=>G & G=>LP switch
In-Reply-To: <CAGsJ_4y1t7Hp5RwUms1r04max98-edeDhag4o520jYJ3T+7t-g@mail.gmail.com>
References: <CAGsJ_4y1t7Hp5RwUms1r04max98-edeDhag4o520jYJ3T+7t-g@mail.gmail.com>
Message-ID: <CAOesGMiXxWuTva4D-keYeMD6LjFbrt9xtd8fjy_8gwDkf_ENbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 28, 2012 at 6:58 AM, Barry Song <21cnbao@gmail.com> wrote:
> hi guys,
> As tegra3 is using vSMP (Variable Symmetric Multiprocessing) arch,
> there are 4 high-performance(G) cores and one low-power(LP) core. At
> runtime, both cpu dynamic hotplug and dynamic LP/G swith are used in a
> real tegra3 product as a DVFS way to save power. kernel log in EeePad:
> *cpu dynamic hotplug*
> <4>[104626.426957] CPU1: Booted secondary processor
> <7>[104627.427412] tegra CPU: force EDP limit 720000 kHz
> <4>[104627.427670] CPU2: Booted secondary processor
> <4>[104628.537005] stop_machine_cpu_stop cpu=0
> <4>[104628.537017] stop_machine_cpu_stop cpu=2
> <4>[104628.537059] stop_machine_cpu_stop cpu=1
> <4>[104628.537702] __stop_cpus: wait_for_completion_timeout+
> <4>[104628.537810] __stop_cpus: smp=0 done.executed=1 done.ret =0-
> <5>[104628.537960] CPU1: clean shutdown
> <4>[104630.537092] stop_machine_cpu_stop cpu=0
> <4>[104630.537172] stop_machine_cpu_stop cpu=2
> <4>[104630.537739] __stop_cpus: wait_for_completion_timeout+
> <4>[104630.538060] __stop_cpus: smp=0 done.executed=1 done.ret =0-
> <5>[104630.538203] CPU2: clean shutdown
> <4>[104631.306984] tegra_watchdog_touch
>
> *G<->LP switch*
> <3>[104666.799152] LP=>G: prolog 22 us, switch 2129 us, epilog 24 us,
> total 2175 us
> <3>[104667.807273] G=>LP: prolog 18 us, switch 157 us, epilog 25 us,
> total 200 us
> <4>[104671.407008] tegra_watchdog_touch
> <4>[104671.408816] nct1008_get_temp: ret temp=35C
> <3>[104671.939060] LP=>G: prolog 17 us, switch 2127 us, epilog 22 us,
> total 2166 us
> <3>[104672.938091] G=>LP: prolog 18 us, switch 156 us, epilog 24 us,
> total 198 us
>
> Related codes don't exist in both http://nv-tegra.nvidia.com/gitweb
> and kernel org, any people know the address to locate these kernel
> source codes?


You need to contact the manufacturer of the device to get the exact
sources (I expect).

That being said, from a quick glance I found code that prints out
those messages on the freshest branch (named rel-14r7) at
nv-tegra.nvidia.com's linux-2.6 repo.


-Olof
