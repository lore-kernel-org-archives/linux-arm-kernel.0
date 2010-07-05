From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Mon, 05 Jul 2010 13:39:40 +0200
Subject: [PATCH] ARM: S5P: Add PMU device
In-Reply-To: <1278294411-5104-1-git-send-email-jy0922.shim@samsung.com>
References: <1278294411-5104-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <4C31C47C.1050905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Op 05-07-10 03:46, Joonyoung Shim schreef:
> This patch adds an initcall for the s5p platforms so that they register
> their PMU IRQs with the PMU framework in the Kernel.
>
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
>  arch/arm/mach-s5p6442/include/mach/irqs.h |    2 +-
>  arch/arm/mach-s5pc100/include/mach/irqs.h |    1 +
>  arch/arm/mach-s5pv210/include/mach/irqs.h |    1 +
>  arch/arm/plat-s5p/Makefile                |    1 +
>  arch/arm/plat-s5p/dev-pmu.c               |   37 +++++++++++++++++++++++++++++
>  5 files changed, 41 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/plat-s5p/dev-pmu.c

Wouldn't it be better if this was in plat-samsung? I can see that the S3C6410
datasheet mentions a PMU_IRQ_ENABLE bit in SYS_OTHERS so I suspect that it has
the same functionality (even though there's no mention of which interrupt this
is).


-- 
Maurus Cuelenaere
