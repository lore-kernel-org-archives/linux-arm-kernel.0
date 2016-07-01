From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 01 Jul 2016 23:01:57 +0200
Subject: [PATCH v6 00/10] acpi,
 clocksource: add GTDT driver and GTDT support in arm_arch_timer
In-Reply-To: <57767782.6020509@linaro.org>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
 <2435381.sM3CFAEXNR@vostro.rjw.lan> <57767782.6020509@linaro.org>
Message-ID: <1643662.QIDsTbCMZg@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 01, 2016 04:00:34 PM Daniel Lezcano wrote:
> On 06/30/2016 03:27 PM, Rafael J. Wysocki wrote:
> 
> [ ... ]
> 
> >> GTDT is part of ACPI spec, drivers/acpi/ is for driver code of
> >> ACPI spec, I think it can stay in drivers/acpi/ from this point
> >> of view, am I right?
> >
> > The question is not "Can it?", but "Does it need to?".
> >
> > It is in the spec, but still there's only one architecture needing it.
> >
> > There is no way to test it on any other architecture and no reason to build it
> > for any other architecture, so why does it need to be located in drivers/acpi/ ?
> 
> Hi Rafael,
> 
> what is the problem of having it in drivers/acpi ?

There's no reason for it to be there.

> There are cpufreq-dt, speedstep*, tegra124-* in drivers/cpufreq.

Yes, they are, but for a reason.  Having them in there makes it easier to
rework and clean up the core.

> clocksource-probe which is DT based with different drivers using it in 
> drivers/clocksource with a pletore of different archs.

So maybe the GTDT code should be there too?

> Cstate code which is only used by x86 is in drivers/acpi, it is only 
> used by x86/ia64 and it isn't a problem.

It is a problem.  drivers/acpi/ is not the right place for arch-specific code.

> There is a small chunk in arch/x86/kernel/acpi and it doesn't facilitate the
> comprehension of the code.
> 
> IMHO, having all ACPI code in the same directory will encourage the 
> consolidation.

The consolidation of what exactly?

In particular, how does the GTDT code in drivers/acpi/ help to consolidate
anything?

Thanks,
Rafael
