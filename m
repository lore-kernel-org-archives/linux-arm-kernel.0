From: marc.w.gonzalez@free.fr (Marc Gonzalez)
Date: Wed, 7 Nov 2018 23:40:22 +0100
Subject: [PATCH v2 7/9] arm64: defconfig: Drop CRYPTO_DEV_FSL_DPAA2_CAAM
In-Reply-To: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
References: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
Message-ID: <a9127a79-ca84-6d39-8910-cc34db526534@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e8342cc7954e ("enable CAAM crypto engine on QorIQ DPAA2 SoCs")
enabled CRYPTO_DEV_FSL_DPAA2_CAAM, which depends on FSL_MC_DPIO,
which is not set.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8e181cca0a05..e4957df18f23 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -727,4 +727,3 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
 CONFIG_MEMTEST=y
-CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=y
-- 
2.17.1
