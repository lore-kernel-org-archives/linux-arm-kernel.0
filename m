From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Jul 2016 17:23:20 +0100
Subject: [PATCH] drivers/perf: arm-pmu: Fix handling of SPI lacking
 "interrupt-affinity" property
In-Reply-To: <1468939142-23693-1-git-send-email-marc.zyngier@arm.com>
References: <1468939142-23693-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160719162319.GA23564@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 03:39:02PM +0100, Marc Zyngier wrote:
> Patch 19a469a58720 ("drivers/perf: arm-pmu: Handle per-interrupt
> affinity mask") added support for partitionned PPI setups, but
> inadvertently broke setups using SPIs without the "interrupt-affinity"
> property (which is the case for UP platforms).
> 
> This patch restore the broken functionnality by testing whether the
> interrupt is percpu or not instead of relying on the using_spi flag
> that really means "SPI *and* interrupt-affinity property".
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: 19a469a58720 ("drivers/perf: arm-pmu: Handle per-interrupt affinity mask")
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/perf/arm_pmu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Thanks, looks good to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Catalin, can you pick this up, please?

Will
