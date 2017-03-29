From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 29 Mar 2017 14:44:32 +0200
Subject: [PATCH 7/7] arm64: defconfig: enable the Safexcel crypto engine as a
 module
In-Reply-To: <20170329124432.27457-1-antoine.tenart@free-electrons.com>
References: <20170329124432.27457-1-antoine.tenart@free-electrons.com>
Message-ID: <20170329124432.27457-8-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Safexcel EIP197 cryptographic engine is used on some Marvell SoCs,
such as Armada 7040 and Armada 8040. Enable this driver as a module in
the ARM64 defconfig.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fece4d3c2095..76308fa2fa7a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -519,6 +519,7 @@ CONFIG_MEMTEST=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_ECHAINIV=y
 CONFIG_CRYPTO_ANSI_CPRNG=y
+CONFIG_CRYPTO_DEV_SAFEXCEL=m
 CONFIG_ARM64_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM64_CE=y
 CONFIG_CRYPTO_SHA2_ARM64_CE=y
-- 
2.11.0
