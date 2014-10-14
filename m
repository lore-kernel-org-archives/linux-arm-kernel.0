From: spang@chromium.org (Michael Spang)
Date: Tue, 14 Oct 2014 16:01:11 -0400
Subject: [PATCH] arm64: Add KEYS_COMPAT to Kconfig & enable
Message-ID: <1413316871-27404-1-git-send-email-spang@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the keyctl compat syscall.

Signed-off-by: Michael Spang <spang@chromium.org>
---
 arch/arm64/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ac9afde..35c3103 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -461,6 +461,11 @@ source "arch/arm64/Kconfig.debug"
 
 source "security/Kconfig"
 
+config KEYS_COMPAT
+	bool
+	depends on COMPAT && KEYS
+	default y
+
 source "crypto/Kconfig"
 if CRYPTO
 source "arch/arm64/crypto/Kconfig"
-- 
2.1.0.rc2.206.gedb03e5
