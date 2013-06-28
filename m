From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Fri, 28 Jun 2013 11:58:40 -0400
Subject: [PATCH v7 0/6] xen/arm/arm64: CONFIG_PARAVIRT and stolen ticks
 accounting
In-Reply-To: <alpine.DEB.2.02.1306271614260.4782@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1306271614260.4782@kaball.uk.xensource.com>
Message-ID: <20130628155840.GA13468@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 12:19:54PM +0100, Stefano Stabellini wrote:
> Hi all,
> this patch series introduces stolen ticks accounting for Xen on ARM and
> ARM64.
> Stolen ticks are clocksource ticks that have been "stolen" from the cpu,
> typically because Linux is running in a virtual machine and the vcpu has
> been descheduled.
> To account for these ticks we introduce CONFIG_PARAVIRT and pv_time_ops
> so that we can make use of:
> 
> kernel/sched/cputime.c:steal_account_process_tick
> 
> 
> Stefano Stabellini (6):
>       xen: move xen_setup_runstate_info and get_runstate_snapshot to drivers/xen/time.c
>       kernel: missing include in cputime.c
>       arm: introduce CONFIG_PARAVIRT, PARAVIRT_TIME_ACCOUNTING and pv_time_ops
>       arm64: introduce CONFIG_PARAVIRT, PARAVIRT_TIME_ACCOUNTING and pv_time_ops
>       core: remove ifdef CONFIG_PARAVIRT
>       xen/arm: account for stolen ticks
> 
>  arch/arm/Kconfig                  |   20 ++++++++
>  arch/arm/include/asm/paravirt.h   |   20 ++++++++
>  arch/arm/kernel/Makefile          |    1 +
>  arch/arm/kernel/paravirt.c        |   25 ++++++++++
>  arch/arm/xen/enlighten.c          |   21 +++++++++
>  arch/arm64/Kconfig                |   20 ++++++++
>  arch/arm64/include/asm/paravirt.h |   20 ++++++++
>  arch/arm64/kernel/Makefile        |    1 +
>  arch/arm64/kernel/paravirt.c      |   25 ++++++++++
>  arch/ia64/xen/time.c              |   48 +++-----------------
>  arch/x86/xen/time.c               |   76 +------------------------------

This is going to hit some of the patches that David
has sent to tglx, I think. You might want to try to rebase on top
of them (tip/time/for-xen, or something like that ) when they
are ready.

But for the Xen generic maintainer I am OK with these changes
so you can stick Acked-by on them.

Are you thinking to push them yourself or via the arm64 maintainer?
