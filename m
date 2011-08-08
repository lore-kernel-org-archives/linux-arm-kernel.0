From: swarren@nvidia.com (Stephen Warren)
Date: Mon,  8 Aug 2011 14:35:13 -0600
Subject: [PATCH v2 1/3] ARM: Tegra: Harmony: Add USB device
In-Reply-To: <1312835715-893-1-git-send-email-swarren@nvidia.com>
References: <1312835715-893-1-git-send-email-swarren@nvidia.com>
Message-ID: <1312835715-893-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tegra USB port is attached an an SMSC9514; a combination USB hub
and Ethernet controller.

This change is extracted from a change in the ChromeOS 2.6.38 kernel.

Signed-off-by: Olof Johansson <olofj@chromium.org>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: No change

 arch/arm/mach-tegra/board-harmony.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index 846cd7d..f528a5a 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -117,6 +117,7 @@ static struct platform_device *harmony_devices[] __initdata = {
 	&tegra_sdhci_device1,
 	&tegra_sdhci_device2,
 	&tegra_sdhci_device4,
+	&tegra_ehci3_device,
 	&tegra_i2s_device1,
 	&tegra_das_device,
 	&tegra_pcm_device,
@@ -140,6 +141,7 @@ static __initdata struct tegra_clk_init_table harmony_clk_init_table[] = {
 	{ "pll_a_out0",	"pll_a",	11289600,	true },
 	{ "cdev1",	NULL,		0,		true },
 	{ "i2s1",	"pll_a_out0",	11289600,	false},
+	{ "usb3",	"clk_m",	12000000,	true },
 	{ NULL,		NULL,		0,		0},
 };
 
-- 
1.7.0.4
