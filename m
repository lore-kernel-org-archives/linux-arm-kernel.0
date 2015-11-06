From: maddy@linux.vnet.ibm.com (Madhavan Srinivasan)
Date: Fri, 6 Nov 2015 12:57:17 +0530
Subject: [RFC PATCH 0/3]perf/core: extend perf_reg and
 perf_sample_regs_intr
In-Reply-To: <20151105130716.GC3604@twins.programming.kicks-ass.net>
References: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20151105130716.GC3604@twins.programming.kicks-ass.net>
Message-ID: <563C5655.3000605@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 05 November 2015 06:37 PM, Peter Zijlstra wrote:
> On Thu, Nov 05, 2015 at 02:16:15AM +0530, Madhavan Srinivasan wrote:
>> Second patch updates struct arch_misc_reg for arch/powerpc with pmu registers
>> and adds offsetof macro for the same. It extends perf_reg_value()
>> to use reg idx to decide on struct to return value from.
> Why; what's in those regs?

Was out and did not have access to mail, so missed to respond in time.

In current implementation of patch 2, have added 
few pmu control/status and counter registers,
which give additional information about the PMU context
for the sample.

These pmu registers are not relevant for ptrace and did not
want to overload pt_regs struct.

Adding these arch specific regs in perf_regs will break the "arch
neutral" part, and
other arch can also use this new struct in perf_regs to add more data
using perf_sample_regs_intr without extending the pt_regs.

Maddy
