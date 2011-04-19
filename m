From: chaos.youn@samsung.com (Changhwan Youn)
Date: Tue, 19 Apr 2011 10:45:23 +0900
Subject: [PATCH 0/3] ARM: SAMSUNG: add entry and exit functions for interrupt
	chained handler
Message-ID: <1303177526-11744-1-git-send-email-chaos.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is for interrupt chained handlers to properly handle the primary controller
using chained_irq_enter and chained_irq_exit functions.
Without this, chained interrupts connected to GIC would not work properly.

This patch series contains:

[PATCH 1/3] ARM: SAMSUNG: add entry and exit functions for uart interrupt chained handler
[PATCH 2/3] ARM: SAMSUNG: add entry and exit functions for pwm interrupt chained handler
[PATCH 3/3] ARM: EXYNOS4: add entry and exit functions for external interrupt chained handler

Best regards,
Changhwan Youn

Patch summary:

Changhwan Youn (3):
	ARM: SAMSUGN: add entry and exit functions for uart interrupt chained handler
	ARM: SAMSUNG: add entry and exit functions for pwm interrupt chained handler
	ARM: EXYNOS4: add entry and exit functions for external interrupt chained handler

	arch/arm/mach-exynos4/irq-eint.c      |   14 +++++++-------
	arch/arm/plat-samsung/irq-uart.c      |    6 ++++++
	arch/arm/plat-samsung/irq-vic-timer.c |    5 +++++
	3 files changed, 18 insertions(+), 7 deletions(-)
