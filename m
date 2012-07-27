From: khilman@ti.com (Kevin Hilman)
Date: Fri, 27 Jul 2012 12:55:13 -0700
Subject: [PATCHv4 6/8] ARM: OMAP: pm-debug: enhanced usecount debug support
In-Reply-To: <1342189185-5306-7-git-send-email-t-kristo@ti.com> (Tero Kristo's
 message of "Fri, 13 Jul 2012 17:19:43 +0300")
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
 <1342189185-5306-7-git-send-email-t-kristo@ti.com>
Message-ID: <87y5m5htcu.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> Voltdm, pwrdm, clkdm, hwmod and clk usecounts are now separeted to
> their own file, 'usecount'. This file shows the usecounts for every
> active domain and their children recursively. 'count' file now only
> shows power state counts for powerdomains.
>
> This patch also provices a way to do printk dumps from kernel code,
> by calling the pm_dbg_dump_X functions. The plan is to call these
> functions once an error condition is detected, e.g. failed suspend.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>

I think we should separate out the debug stuff as a separate patch set.

Where I want to go with PM debug is away from in-kernel debug prints and
towards using tracepoints.  We have tracepoints in the clock code that
correspond to usecounts, but we need them in the clkdm, pwrdm and voltdm
code as well.  With that, you can use userspace tools (perf, ftrace) to
trace a problem (e.g. failed suspend) and see voltdm/pwrdm/clkdm/clks
are on when they shouldn't be.

Kevin
