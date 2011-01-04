From: balbi@ti.com (Felipe Balbi)
Date: Tue,  4 Jan 2011 11:39:26 +0200
Subject: [PATCH 2/2] arm: omap: select HAVE_SPARSE_IRQ
In-Reply-To: <1294133966-20279-1-git-send-email-balbi@ti.com>
References: <1294133966-20279-1-git-send-email-balbi@ti.com>
Message-ID: <1294133966-20279-3-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

select HAVE_SPARSE_IRQ and irq_descs can be added
to a radix tree instead of an array.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d56d21c0..c4ffe2e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -826,6 +826,8 @@ config ARCH_DAVINCI
 config ARCH_OMAP
 	bool "TI OMAP"
 	select HAVE_CLK
+	select HAVE_GENERIC_HARDIRQS
+	select HAVE_SPARSE_IRQ
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
 	select GENERIC_CLOCKEVENTS
-- 
1.7.3.4.598.g85356
