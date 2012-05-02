From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 02 May 2012 13:02:47 +0530
Subject: About CPU hotplug stress test failed
In-Reply-To: <CAB4PhKf06wNA_=QEe3uT9u25WaxVHAenWADCA49hUwJxcPGdwA@mail.gmail.com>
References: <CAB4PhKf06wNA_=QEe3uT9u25WaxVHAenWADCA49hUwJxcPGdwA@mail.gmail.com>
Message-ID: <4FA0E31F.8090304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 May 2012 12:46 PM, Jason Liu wrote:
> Hi, kernel experts
> 
>  We met CPU hotplug issue on v3.0.15 and event the latest v3.4,
> sometimes system hang when doing stress test of CPU hotplug which is
> simply to remove all secondary cores(core1 ~ core3) and add them back,
> the failure is in random. But we didn?t meet any issue on V2.6.38, so
> I guess it is pure kernel issue, do you have any idea about it? Or did
> you meet any similar issue on other platform(OMAP, SAMSUNG or Tegra)?
> Thanks in advanced!
> 
> 
I haven't observed yet such issue on OMAP with 3.4 but there were issues
seen before the cpu_active fixes. You can look at commit "5fbd036b" for more
information.

In your report, you haven't mentioned much. What you mean by system
hang. What is the state of CPU's at the time of hang ? Are you getting
some CPU stalled kind of messages ? You can enable the debug support so
that kernel will panic if CPUs are stalled.

Regards
Santosh
