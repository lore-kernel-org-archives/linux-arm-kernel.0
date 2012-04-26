From: wcohen@redhat.com (William Cohen)
Date: Thu, 26 Apr 2012 11:29:17 -0400
Subject: [PATCH 1/3] Add the Performance Monitoring Unit to the Trimslice
 device tree
Message-ID: <1335454157-4881-1-git-send-email-wcohen@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tegra processor has a performance monitoring unit. However, this
was not listed on the board-trimslice.c devices. This patch adds
it to the list of devices and allows one to use hardware performance
monitoring events on the trimslice machine.

Signed-off-by: William Cohen <wcohen@redhat.com>
---
 arch/arm/mach-tegra/board-trimslice.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index cd52820..0484903 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -82,6 +82,7 @@ static struct platform_device trimslice_audio_device = {
 
 static struct platform_device *trimslice_devices[] __initdata = {
 	&debug_uart,
+	&tegra_pmu_device,
 	&tegra_sdhci_device1,
 	&tegra_sdhci_device4,
 	&tegra_i2s_device1,
-- 
1.7.10
