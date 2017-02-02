From: will.deacon@arm.com (Will Deacon)
Date: Thu, 2 Feb 2017 12:47:27 +0000
Subject: irq_work_run called from armv8pmu_handle_irq
In-Reply-To: <762e1210e12fbc693b3d0e27361df53f@codeaurora.org>
References: <762e1210e12fbc693b3d0e27361df53f@codeaurora.org>
Message-ID: <20170202124727.GA13839@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 12:15:01PM -0800, Sodagudi Prasad wrote:
> we would like to understand why irq_work_run() is getting called from
> armv8pmu_handle_irq() irq handler for arm SoC.
> 
> Is this irq_work frame work designed to run works from ARMPMU irq handlers?
> If there are no of drivers using the IRQ WORK frame work,  we may see that
> ARMPMU irq handler taking long time, right?

The perf_event_overflow callback can schedule IRQ work to e.g. disable the
PMU and want to make sure this runs before we EOI the PMU IRQ.

Will
