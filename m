From: balbi@ti.com (Felipe Balbi)
Date: Tue, 17 May 2011 02:46:12 +0300
Subject: [RESEND/PATCH 2/2] arm: Kconfig: allow OMAP to use sparse IRQ
	numbering
In-Reply-To: <1305589572-5812-1-git-send-email-balbi@ti.com>
References: <1305589572-5812-1-git-send-email-balbi@ti.com>
Message-ID: <1305589572-5812-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select HAVE_SPARSE_IRQ to allow OMAP to use
sparse IRQ numbering scheme. The main difference
is that irq_descs will be added to a radix tree
instead of a static array.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 416b02f..d5e2571 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -861,6 +861,7 @@ config ARCH_DAVINCI
 config ARCH_OMAP
 	bool "TI OMAP"
 	select HAVE_CLK
+	select HAVE_SPARSE_IRQ
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
 	select GENERIC_CLOCKEVENTS
-- 
1.7.4.1.343.ga91df
