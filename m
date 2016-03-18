From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 18 Mar 2016 01:41:06 +0100
Subject: [PATCH v4 0/5] acpi, clocksource,
 kvm: add GTDT and ARM memory-mapped timer support
In-Reply-To: <56EAC832.6070203@codeaurora.org>
References: <1458199917-30699-1-git-send-email-fu.wei@linaro.org>
 <56EAC832.6070203@codeaurora.org>
Message-ID: <2196518.cd4jtVChuo@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 17, 2016 10:07:30 AM Timur Tabi wrote:
> fu.wei at linaro.org wrote:
> > From: Fu Wei <fu.wei@linaro.org>
> >
> > This patchset:
> >      (1)Move some enums and marcos to header file for arm_arch_timer,
> >      improve the pr_* code by defining "pr_fmt(fmt)" in arm_arch_timer.c
> >
> >      (2)Introduce ACPI GTDT parser: drivers/acpi/gtdt.c
> >      Parse all kinds of timer in GTDT table of ACPI:arch timer,
> >      memory-mapped timer and SBSA Generic Watchdog timer.
> >      This driver can help to simplify all the relevant timer drivers,
> >      and separate all the ACPI GTDT knowledge from them.
> >
> >      (3)Simplify ACPI code for arch timer in arm_arch_timer.c
> >
> >      (4)Add memory-mapped timer support in arm_arch_timer.c
> 
> The SBSA watchdog driver is already in watchdog-next and will be merged 
> into 4.6.  These five patches are necessary for the watchdog driver to 
> probe on an ACPI system.
> 
> I'm guessing since that v4 was posted in the middle of the 4.6 merge 
> window, that these patches won't make it and we'll have to wait until 
> 4.7 (at the earliest)?

First off, the last version I've seen is the v3.  I must have overlooked
the v4 then, but I don't think it was CCed to linux-acpi (which should
have happened).

Second, these patches require review from multiple maintainers and (or including)
people who actually know how the GTDT is supposed to be used.  I haven't
seen any responses from any of them yet, so the answer to your question is
"yes".

I will have a couple of comments for patch [1/6] (in the v3), but it's
not been a priority due to the apparent overall lack of interest in this
series.

Thanks,
Rafael
