From: jeffv@google.com (Jeff Vander Stoep)
Date: Tue, 18 Aug 2015 12:29:37 -0700
Subject: [PATCH] arm64 Kconfig: Move LIST_POISON to a safe value
Message-ID: <1439926177-13839-1-git-send-email-jeffv@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the poison pointer offset to 0xdead000000000000, a
recognized value that is not mappable by user-space exploits.

Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
 arch/arm64/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9532f8d..c003911 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -91,6 +91,11 @@ config NO_IOPORT_MAP
 config STACKTRACE_SUPPORT
 	def_bool y
 
+config ILLEGAL_POINTER_VALUE
+	hex
+	default 0xdead000000000000
+
+
 config LOCKDEP_SUPPORT
 	def_bool y
 
-- 
2.5.0.rc2.392.g76e840b
