From: balbi@ti.com (Felipe Balbi)
Date: Thu, 20 Jan 2011 08:43:32 +0200
Subject: [RESEND PATCH 3/3] arm: Kconfig: allow OMAP to use sparse IRQ
	numbering
In-Reply-To: <1295505812-5062-1-git-send-email-balbi@ti.com>
References: <1295505812-5062-1-git-send-email-balbi@ti.com>
Message-ID: <1295505812-5062-4-git-send-email-balbi@ti.com>
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
index c231192..d0b5b26 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -858,6 +858,7 @@ config ARCH_DAVINCI
 config ARCH_OMAP
 	bool "TI OMAP"
 	select HAVE_CLK
+	select HAVE_SPARSE_IRQ
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
 	select GENERIC_CLOCKEVENTS
-- 
1.7.4.rc2
