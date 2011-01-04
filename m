From: balbi@ti.com (Felipe Balbi)
Date: Tue,  4 Jan 2011 14:02:57 +0200
Subject: [PATCH 4/4] arm: Kconfig: allow OMAP to use sparse IRQ numbering
In-Reply-To: <1294142577-28772-1-git-send-email-balbi@ti.com>
References: <1294142577-28772-1-git-send-email-balbi@ti.com>
Message-ID: <1294142577-28772-5-git-send-email-balbi@ti.com>
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
index 106d9f6..2413aa6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -820,6 +820,7 @@ config ARCH_DAVINCI
 config ARCH_OMAP
 	bool "TI OMAP"
 	select HAVE_CLK
+	select HAVE_SPARSE_IRQ
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
 	select GENERIC_CLOCKEVENTS
-- 
1.7.3.4.598.g85356
