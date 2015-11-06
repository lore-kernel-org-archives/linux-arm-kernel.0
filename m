From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 6 Nov 2015 10:24:30 +0100
Subject: [RFC PATCH 0/3]perf/core: extend perf_reg and
 perf_sample_regs_intr
In-Reply-To: <563C5655.3000605@linux.vnet.ibm.com>
References: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20151105130716.GC3604@twins.programming.kicks-ass.net>
 <563C5655.3000605@linux.vnet.ibm.com>
Message-ID: <20151106092430.GO3604@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 12:57:17PM +0530, Madhavan Srinivasan wrote:
> 
> 
> On Thursday 05 November 2015 06:37 PM, Peter Zijlstra wrote:
> > On Thu, Nov 05, 2015 at 02:16:15AM +0530, Madhavan Srinivasan wrote:
> >> Second patch updates struct arch_misc_reg for arch/powerpc with pmu registers
> >> and adds offsetof macro for the same. It extends perf_reg_value()
> >> to use reg idx to decide on struct to return value from.
> > Why; what's in those regs?
> 
> Was out and did not have access to mail, so missed to respond in time.
> 
> In current implementation of patch 2, have added 
> few pmu control/status and counter registers,
> which give additional information about the PMU context
> for the sample.

Yes, I saw that, you still haven't answered the question though. What is
in those regs? Why is exposing that information like this the best
option.
