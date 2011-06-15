From: balbi@ti.com (Felipe Balbi)
Date: Wed, 15 Jun 2011 16:02:40 +0300
Subject: [RESEND PATCH 2/2] arm: Kconfig: allow OMAP to use sparse IRQ
	numbering
In-Reply-To: <1308142960-20767-1-git-send-email-balbi@ti.com>
References: <1308142960-20767-1-git-send-email-balbi@ti.com>
Message-ID: <1308142960-20767-3-git-send-email-balbi@ti.com>
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
index a061525..bdb6244 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -850,6 +850,7 @@ config ARCH_DAVINCI
 config ARCH_OMAP
 	bool "TI OMAP"
 	select HAVE_CLK
+	select HAVE_SPARSE_IRQ
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
 	select GENERIC_CLOCKEVENTS
-- 
1.7.6.rc1
