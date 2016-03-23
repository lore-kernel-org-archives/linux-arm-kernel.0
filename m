From: majun258@huawei.com (MaJun)
Date: Wed, 23 Mar 2016 17:06:32 +0800
Subject: [PATCH 1/2]ARM64: Enable mbigen interrupt controller on Hisilicon
 platform
In-Reply-To: <1458723993-21044-1-git-send-email-majun258@huawei.com>
References: <1458723993-21044-1-git-send-email-majun258@huawei.com>
Message-ID: <1458723993-21044-2-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

As a interrupt controller used on some of hisilicon SOCs(660,1610 etc.),
mbigen driver should be enabled when CONFIG_ARCH_HISI is enabled.
Signed-off-by: Ma Jun <majun258@huawei.com>
---
 arch/arm64/Kconfig.platforms |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 21074f6..fdfd526 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -37,6 +37,7 @@ config ARCH_LAYERSCAPE
 
 config ARCH_HISI
 	bool "Hisilicon SoC Family"
+	select HISILICON_IRQ_MBIGEN
 	help
 	  This enables support for Hisilicon ARMv8 SoC family
 
-- 
1.7.1
