From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Mar 2011 14:00:58 -0000
Subject: [PATCH 2/3] arm: pmu: support pmu irq routed from CTI
In-Reply-To: <1298985434-3009-3-git-send-email-tom.leiming@gmail.com>
References: <1298985434-3009-1-git-send-email-tom.leiming@gmail.com>
	<1298985434-3009-3-git-send-email-tom.leiming@gmail.com>
Message-ID: <000601cbd819$1780a540$4681efc0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> Subject: [PATCH 2/3] arm: pmu: support pmu irq routed from CTI
> 
> From: Ming Lei <tom.leiming@gmail.com>
> 
> This patch introduces pmu_platform_data struct to
> support pmu irq routed from CTI, such as implemented
> on OMAP4.
> 
> Generally speaking, clearing cti irq should be done in
> irq handler, also enabling cti module after calling
> request_irq and disabling cti module before calling
> free_irq.
> 
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  arch/arm/include/asm/pmu.h   |   12 ++++++++++
>  arch/arm/kernel/perf_event.c |   51 ++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 56 insertions(+), 7 deletions(-)

This will conflict with the the ux500 PMU workaround:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/041145.html

Will
