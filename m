From: jglauber@cavium.com (Jan Glauber)
Date: Fri,  2 Mar 2018 15:37:37 +0100
Subject: [PATCH 2/2] arm64: defconfig: Raise NR_CPUS to 256
In-Reply-To: <20180302143737.10788-1-jglauber@cavium.com>
References: <20180302143737.10788-1-jglauber@cavium.com>
Message-ID: <20180302143737.10788-2-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ThunderX1 dual socket has 96 CPUs and ThunderX2 has 224 CPUs.
Therefore raise the default number of CPUs from 64 to 256
by adding an arm64 specific option to override the generic default.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3594aefa496f..970950e8c76b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -630,3 +630,4 @@ CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
 CONFIG_CRYPTO_AES_ARM64_NEON_BLK=m
 CONFIG_CRYPTO_CHACHA20_NEON=m
 CONFIG_CRYPTO_AES_ARM64_BS=m
+CONFIG_NR_CPUS=256
-- 
2.7.4
