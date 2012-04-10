From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 10 Apr 2012 17:19:38 -0600
Subject: [PATCH V2 3/5] ARM: tegra: add AUXDATA required for audio
In-Reply-To: <1334099980-19527-1-git-send-email-swarren@wwwdotorg.org>
References: <1334099980-19527-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1334099980-19527-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Both the Tegra30 I2S and AHUB modules used clocks, and hence currently
require AUXDATA in order to get specific device names so that clock
lookups work.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Remove AUXDATA for I2S devices; this is included in the AHUB driver now
that it's the bus that contains the I2S devices.
---
 arch/arm/mach-tegra/board-dt-tegra30.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-dt-tegra30.c b/arch/arm/mach-tegra/board-dt-tegra30.c
index 3de21c0..d96dae0 100644
--- a/arch/arm/mach-tegra/board-dt-tegra30.c
+++ b/arch/arm/mach-tegra/board-dt-tegra30.c
@@ -51,6 +51,7 @@ struct of_dev_auxdata tegra30_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("nvidia,tegra20-i2c", 0x7000C500, "tegra-i2c.2", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-i2c", 0x7000C700, "tegra-i2c.3", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-i2c", 0x7000D000, "tegra-i2c.4", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra30-ahub", 0x70080000, "tegra30-ahub", NULL),
 	{}
 };
 
-- 
1.7.0.4
