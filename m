From: dja@axtens.net (Daniel Axtens)
Date: Wed, 19 Jul 2017 11:28:39 +1000
Subject: [PATCH 4/4] arm64: allow non-legacy VGA devices to be default
In-Reply-To: <20170719012839.20124-1-dja@axtens.net>
References: <20170719012839.20124-1-dja@axtens.net>
Message-ID: <20170719012839.20124-7-dja@axtens.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VGA arbiter only marks a device as default if it can decode
legacy I/O and memory ranges. This is often not the case on arm64,
which doesn't use the legacy ranges.

Enable the VGA arbiter to mark the first enabled VGA card as
default.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

Tested on a D05 using the hibmc card.
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index dfd908630631..cefcbd442e4f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -28,6 +28,7 @@ config ARM64
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
+	select ARCH_WANT_VGA_ARB_FALLBACK
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
-- 
2.11.0
