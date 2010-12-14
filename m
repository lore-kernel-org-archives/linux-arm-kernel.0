From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 14 Dec 2010 18:57:03 +0900
Subject: [PATCH 00/03] ARM: mach-shmobile: Initial SMP support
In-Reply-To: <20101214075647.11275.25933.sendpatchset@t400s>
References: <20101214075647.11275.25933.sendpatchset@t400s>
Message-ID: <20101214095703.GG14606@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 14, 2010 at 04:56:47PM +0900, Magnus Damm wrote:
> ARM: mach-shmobile: Initial SMP support
> 
> [PATCH 01/03] ARM: mach-shmobile: SMP base support 
> [PATCH 02/03] ARM: mach-shmobile: Enable SMP support
> [PATCH 03/03] ARM: mach-shmobile: sh73a0 SMP support
> 
> These patches add SMP framework support for R-Mobile and
> SH-Mobile processors, together with hardware specific SMP
> support for the sh73a0 processor.
> 
> Survives onlining and offlining of secondary processor cores
> through sysfs. Should compile and boot regardless of 
> CONFIG_SMP, CONFIG_HOTPLUG_CPU and CONFIG_LOCAL_TIMERS.
> 
> I suggest that patch 1 and 3 are taken through sh-2.6 and
> patch 2 goes through the RMK patch tracker.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied to rmobile/smp, thanks.

There are integration issues with regards to the GIC changes that I'll
have to take care of during the merge window regardless, so resolving the
CONFIG_SMP thing at that point should be pretty straightforward. My plan
is to wait until after Russell merges, merge your stuff on top of that,
and then send the updated bits to Linus in one shot.

In order to avoid clashes with -next for now however I won't be merging
the topic branch in to my -latest branch. Given that the number of boards
in the wild for this at the moment are in the single digits, I'm not too
worried about the amount of time these changes spend in -next so long as
no regressions are introduced for the other boards.
