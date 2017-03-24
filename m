From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 24 Mar 2017 21:26:06 +0300
Subject: [PATCH v2 3/3] ARM: multi_v7_defconfig: Enable Exynos RNG and
 user-space crypto API
In-Reply-To: <20170324182606.23339-1-krzk@kernel.org>
References: <20170324182606.23339-1-krzk@kernel.org>
Message-ID: <20170324182606.23339-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the new Exynos pseudo random number generator driver and
user-space API to access crypto algorithms and devices (not only RNG).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/multi_v7_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 36c1b39cfb54..9bc1bd7f2afa 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -935,7 +935,13 @@ CONFIG_CPUFREQ_DT=y
 CONFIG_KEYSTONE_IRQ=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_ST=y
+CONFIG_CRYPTO_USER=m
+CONFIG_CRYPTO_USER_API_HASH=m
+CONFIG_CRYPTO_USER_API_SKCIPHER=m
+CONFIG_CRYPTO_USER_API_RNG=m
+CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_CRYPTO_DEV_MARVELL_CESA=m
+CONFIG_CRYPTO_DEV_EXYNOS_RNG=m
 CONFIG_CRYPTO_DEV_S5P=m
 CONFIG_CRYPTO_DEV_SUN4I_SS=m
 CONFIG_CRYPTO_DEV_ROCKCHIP=m
-- 
2.9.3
