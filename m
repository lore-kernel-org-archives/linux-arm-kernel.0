From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 4 Jan 2017 11:15:07 +0100
Subject: [RFC PATCH 06/10] perf/core: Export AUX buffer helpers to modules
In-Reply-To: <1483467027-14547-7-git-send-email-will.deacon@arm.com>
References: <1483467027-14547-1-git-send-email-will.deacon@arm.com>
 <1483467027-14547-7-git-send-email-will.deacon@arm.com>
Message-ID: <20170104101507.GG25813@worktop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 06:10:23PM +0000, Will Deacon wrote:
> +EXPORT_SYMBOL(perf_aux_output_begin);
> +EXPORT_SYMBOL(perf_aux_output_end);
> +EXPORT_SYMBOL(perf_aux_output_skip);
> +EXPORT_SYMBOL(perf_get_aux);


$ git grep EXPORT kernel/events/
kernel/events/core.c:EXPORT_SYMBOL_GPL(perf_event_disable);
kernel/events/core.c:EXPORT_SYMBOL_GPL(perf_event_enable);
kernel/events/core.c:EXPORT_SYMBOL_GPL(perf_event_addr_filters_sync);
kernel/events/core.c:EXPORT_SYMBOL_GPL(perf_event_refresh);
kernel/events/core.c:EXPORT_SYMBOL_GPL(perf_event_release_kernel);
kernel/events/core.c:EXPORT_SYMBOL_GPL(perf_event_read_value);
kernel/events/core.c:EXPORT_SYMBOL_GPL(perf_register_guest_info_callbacks);
kernel/events/core.c:EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
kernel/events/core.c:EXPORT_SYMBOL_GPL(perf_swevent_get_recursion_context);
kernel/events/core.c:EXPORT_SYMBOL_GPL(perf_trace_run_bpf_submit);
kernel/events/core.c:EXPORT_SYMBOL_GPL(perf_tp_event);
kernel/events/core.c:EXPORT_SYMBOL_GPL(perf_pmu_register);
kernel/events/core.c:EXPORT_SYMBOL_GPL(perf_pmu_unregister);
kernel/events/core.c:EXPORT_SYMBOL_GPL(perf_event_create_kernel_counter);
kernel/events/core.c:EXPORT_SYMBOL_GPL(perf_pmu_migrate_context);
kernel/events/core.c:EXPORT_SYMBOL_GPL(perf_event_sysfs_show);
kernel/events/hw_breakpoint.c:EXPORT_SYMBOL_GPL(register_user_hw_breakpoint);
kernel/events/hw_breakpoint.c:EXPORT_SYMBOL_GPL(modify_user_hw_breakpoint);
kernel/events/hw_breakpoint.c:EXPORT_SYMBOL_GPL(unregister_hw_breakpoint);
kernel/events/hw_breakpoint.c:EXPORT_SYMBOL_GPL(register_wide_hw_breakpoint);
kernel/events/hw_breakpoint.c:EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
kernel/events/uprobes.c:EXPORT_SYMBOL_GPL(uprobe_register);
kernel/events/uprobes.c:EXPORT_SYMBOL_GPL(uprobe_unregister);

I see a distinct difference here... :-)
