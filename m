From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 30 Mar 2012 16:59:59 -0600
Subject: [PATCH 06/11] ARM: tegra: seaboard: Don't gpio_request() ISL29018_IRQ
In-Reply-To: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1333148404-17691-7-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Don't call gpio_request() or gpio_direction_input() for ISL29018_IRQ.
This pin is only used as an IRQ, and hence no GPIO configuration should
be necessary; the GPIO/IRQ driver should (and does) perform any required
setup when the IRQ is requested.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-seaboard.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
index e6642c6..0b2b9ce 100644
--- a/arch/arm/mach-tegra/board-seaboard.c
+++ b/arch/arm/mach-tegra/board-seaboard.c
@@ -199,9 +199,6 @@ static int seaboard_ehci_init(void)
 
 static void __init seaboard_i2c_init(void)
 {
-	gpio_request(TEGRA_GPIO_ISL29018_IRQ, "isl29018");
-	gpio_direction_input(TEGRA_GPIO_ISL29018_IRQ);
-
 	isl29018_device.irq = gpio_to_irq(TEGRA_GPIO_ISL29018_IRQ);
 	i2c_register_board_info(0, &isl29018_device, 1);
 
-- 
1.7.0.4
