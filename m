From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 27 Nov 2012 13:16:52 +0800
Subject: [PATCH] cpufreq: SPEAr: Add CPUFreq driver
In-Reply-To: <CAKohpomSAogQVeBQ8HaWwwoTVCsMha5d_1Wid6N3t5SnVZTc=w@mail.gmail.com>
References: <7ec0e3f4b81b70f3def4257e6b9781efd4c7a3d2.1353785862.git.viresh.kumar@linaro.org>
 <20121127040135.GB27305@S2100-06.ap.freescale.net>
 <CAKohpomSAogQVeBQ8HaWwwoTVCsMha5d_1Wid6N3t5SnVZTc=w@mail.gmail.com>
Message-ID: <20121127051649.GC27305@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 09:28:01AM +0530, Viresh Kumar wrote:
> >> +     if (of_machine_is_compatible("st,spear1340")) {
> >> +             /*
> >> +              * SPEAr1340 is special in the sense that due to the possibility
> >> +              * of multiple clock sources for cpu clk's parent we can have
> >> +              * different clock source for different frequency of cpu clk.
> >> +              * Hence we need to choose one from amongst these possible clock
> >> +              * sources.
> >> +              */
> >> +             srcclk = spear1340_cpu_get_possible_parent(newfreq);
> >
> > From what I can see, if spear1340 clock driver can handle such special
> > setup of clk, the driver will be nothing SPEAr specific and can probably
> > be saved by just using cpufreq-cpu0.
> 
> There are few more patches we have for this driver, which are depending
> on some mach stuff to be pushed first. We need to program system controller
> too for make cpu clock transitions more stable.

Shouldn't it also be handled by cpu clock provider?

Shawn

> They should come after some
> time.
