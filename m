From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Aug 2017 11:25:09 +0200
Subject: [PATCH 2/2] soc/tegra: fuse: Add missing semi-colon
In-Reply-To: <20170823092509.5243-1-thierry.reding@gmail.com>
References: <20170823092509.5243-1-thierry.reding@gmail.com>
Message-ID: <20170823092509.5243-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Commit 8a46828e623c ("soc/tegra: Register SoC device") added a new
initcall, but forgot to terminate the line with a semi-colon. Some
recent versions of GCC seem to report this as an error.

Fixes: 8a46828e623c ("soc/tegra: Register SoC device")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index be003d04383f..b7c552e3133c 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -364,5 +364,5 @@ static int __init tegra_init_soc(void)
 
 	return 0;
 }
-device_initcall(tegra_init_soc)
+device_initcall(tegra_init_soc);
 #endif
-- 
2.13.3
