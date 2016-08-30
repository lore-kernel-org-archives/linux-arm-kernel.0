From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Aug 2016 12:27:19 +0100
Subject: [PATCH 2/2] drivers/perf: arm_pmu: Fix NULL pointer dereference
 during probe
In-Reply-To: <1472314790-4268-2-git-send-email-stefan.wahren@i2se.com>
References: <1472314790-4268-1-git-send-email-stefan.wahren@i2se.com>
 <1472314790-4268-2-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20160830112718.GC24906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 27, 2016 at 04:19:50PM +0000, Stefan Wahren wrote:
> Patch 7f1d642fbb5c ("drivers/perf: arm-pmu: Fix handling of SPI lacking
> interrupt-affinity property") unintended also fixes perf_event support
> for bcm2835 which doesn't have PMU interrupts. Unfortunately this change
> introduce a NULL pointer dereference on bcm2835, because irq_is_percpu
> always expected to be called with a valid IRQ. So fix this regression
> by validating the IRQ before.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: 7f1d642fbb5c ("drivers/perf: arm-pmu: Fix handling of SPI lacking \"interrupt-affinity\" property")
> ---
>  drivers/perf/arm_pmu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, these two look good to me. I'll queue them up as fixes and hopefully
they'll land in -rc5.

Will
