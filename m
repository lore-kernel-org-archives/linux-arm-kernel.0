From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 26 Jul 2017 09:49:48 +0200
Subject: [PATCH V2 1/4] hw_breakpoint: Add step_needed event attribute
In-Reply-To: <70b51184-dbe0-6d0b-c853-be5b556927f1@redhat.com>
References: <cover.1499416107.git.panand@redhat.com>
 <9d4f76f3a0bffe93a6d5146c9b53ee7b985f22da.1499416107.git.panand@redhat.com>
 <20170725132737.GC28815@arm.com>
 <70b51184-dbe0-6d0b-c853-be5b556927f1@redhat.com>
Message-ID: <20170726074947.qynkabkdpfmcjj2l@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 11:12:03AM +0530, Pratyush Anand wrote:
> I too had thought to put it under include/linux/perf_event.h : struct
> perf_event. But, see hw_break_module_init() which does not have knowledge of
> this structure, and we need to have some way so that none-perf kernel module
> implementation can tell that it needs default arch step handler.
> 
> Do you see any alternative?

Fix the hw_breakpoint interface?
