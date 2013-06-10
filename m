From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 10 Jun 2013 16:05:07 +0100
Subject: [PATCH 2/2] clk: vexpress: Make the clock drivers directly available
 for arm64
In-Reply-To: <1370876707-25265-1-git-send-email-pawel.moll@arm.com>
References: <1370876707-25265-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1370876707-25265-3-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new arm64 architecture has no idea of platform or machine, so
it doesn't have to define ARCH_VEXPRESS configuration option at
all. To allow user to select the drivers at all, make it depend
on ARM64 as well.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 drivers/clk/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 0357ac4..d0d9b21 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -42,7 +42,7 @@ config COMMON_CLK_WM831X
 
 config COMMON_CLK_VERSATILE
 	bool "Clock driver for ARM Reference designs"
-	depends on ARCH_INTEGRATOR || ARCH_REALVIEW || ARCH_VEXPRESS
+	depends on ARCH_INTEGRATOR || ARCH_REALVIEW || ARCH_VEXPRESS || ARM64
 	---help---
           Supports clocking on ARM Reference designs:
 	  - Integrator/AP and Integrator/CP
-- 
1.8.1.2
