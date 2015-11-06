From: sukadev@linux.vnet.ibm.com (Sukadev Bhattiprolu)
Date: Thu, 5 Nov 2015 18:58:45 -0800
Subject: [RFC PATCH  0/3]perf/core: extend perf_reg and
 perf_sample_regs_intr
In-Reply-To: <20151105130716.GC3604@twins.programming.kicks-ass.net>
References: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20151105130716.GC3604@twins.programming.kicks-ass.net>
Message-ID: <20151106025844.GA28859@us.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Zijlstra [peterz at infradead.org] wrote:
| On Thu, Nov 05, 2015 at 02:16:15AM +0530, Madhavan Srinivasan wrote:
| > Second patch updates struct arch_misc_reg for arch/powerpc with pmu registers
| > and adds offsetof macro for the same. It extends perf_reg_value()
| > to use reg idx to decide on struct to return value from.
| 
| Why; what's in those regs?

Those are PMU control registers/counters (in Patch 2) that are of
interest only in the context of a PMU interrupt and not relevant
to ptrace itself.

Could we add those registers to 'struct pt_regs' anyway?

We do have 'struct perf_regs' but that seems to be arch nuetral.
If architectures could override that, maybe we could add these
new registers there without touching 'struct pt_regs'.

Even so, lot of perf code depends on 'struct pt_regs'.

Sukadev
