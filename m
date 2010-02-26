From: mingo@elte.hu (Ingo Molnar)
Date: Fri, 26 Feb 2010 09:23:15 +0100
Subject: [PATCH 4/6] perf-events: export enable/disable event symbols to
	kernel modules
In-Reply-To: <1267124175-21721-5-git-send-email-will.deacon@arm.com>
References: <1267124175-21721-1-git-send-email-will.deacon@arm.com>
	<1267124175-21721-2-git-send-email-will.deacon@arm.com>
	<1267124175-21721-3-git-send-email-will.deacon@arm.com>
	<1267124175-21721-4-git-send-email-will.deacon@arm.com>
	<1267124175-21721-5-git-send-email-will.deacon@arm.com>
Message-ID: <20100226082315.GC15885@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Will Deacon <will.deacon@arm.com> wrote:

> The perf_event_enable and perf_event_disable functions are used to
> control the activation of perf-events for a given context or CPU.
> 
> This patch exports these symbols so that they can be used by kernel
> modules. Without these symbols, an event must be destroyed and recreated
> to disable or enable it respectively. The maximum number of perf-events
> is also made available to modules via the perf_get_max_events function.
> 
> Cc: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  include/linux/perf_event.h |    1 +
>  kernel/perf_event.c        |    8 ++++++++
>  2 files changed, 9 insertions(+), 0 deletions(-)

Hm, what modules would like to use them, and in what fashion?

Thanks,

	Ingo
