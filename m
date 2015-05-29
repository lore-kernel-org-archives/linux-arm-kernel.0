From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Thu, 28 May 2015 19:14:10 -0700
Subject: [PATCH v2 6/6] ARM: brcmstb: Add default gpio number
In-Reply-To: <1432865650-4062-1-git-send-email-gregory.0xf0@gmail.com>
References: <1432865650-4062-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <1432865650-4062-7-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Out of the brcmstb SoCs that I know, BCM3390 has the largest numbers
of GPIOs, with its
- 320 "peripheral" GPIOs
- 5*32 = 160 UPG GPIOs (counting unused lines, which do get counted)
- 2*32 = 64 UPG AON GPIOs (counting unused lines)
Total: 544

I suspect that the upper limit will only need to be higher in the
future, so set it to 1024.

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
New in v2.

 arch/arm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e717642..bbe6bf7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1509,7 +1509,8 @@ config ARM_PSCI
 # selected platforms.
 config ARCH_NR_GPIO
 	int
-	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA || ARCH_ZYNQ
+	default 1024 if ARCH_BRCMSTB || ARCH_SHMOBILE || ARCH_TEGRA || \
+		ARCH_ZYNQ
 	default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 || \
 		SOC_DRA7XX || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
 	default 416 if ARCH_SUNXI
-- 
1.9.1
