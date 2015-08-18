From: jeffv@google.com (Jeff Vander Stoep)
Date: Tue, 18 Aug 2015 12:50:10 -0700
Subject: [PATCH v2] arm64 Kconfig: Move LIST_POISON to a safe value
Message-ID: <1439927410-15522-1-git-send-email-jeffv@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the poison pointer offset to 0xdead000000000000, a
recognized value that is not mappable by user-space exploits.

Signed-off-by: Thierry Strudel <tstrudel@google.com>
Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
v2 removes an extra newline.

 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 318175f..8f1789c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -104,6 +104,10 @@ config NO_IOPORT_MAP
 config STACKTRACE_SUPPORT
 	def_bool y
 
+config ILLEGAL_POINTER_VALUE
+	hex
+	default 0xdead000000000000
+
 config LOCKDEP_SUPPORT
 	def_bool y
 
-- 
2.5.0.276.gf5e568e
