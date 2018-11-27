From: andreyknvl@google.com (Andrey Konovalov)
Date: Tue, 27 Nov 2018 17:55:41 +0100
Subject: [PATCH v12 23/25] kasan, arm64: select HAVE_ARCH_KASAN_SW_TAGS
In-Reply-To: <cover.1543337629.git.andreyknvl@google.com>
References: <cover.1543337629.git.andreyknvl@google.com>
Message-ID: <996c9b3898bb3c5de977d00215ddc4bf8cf154c1.1543337629.git.andreyknvl@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, that all the necessary infrastructure code has been introduced,
select HAVE_ARCH_KASAN_SW_TAGS for arm64 to enable software tag-based
KASAN mode.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 787d7850e064..8b331dcfb48e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -111,6 +111,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
+	select HAVE_ARCH_KASAN_SW_TAGS if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog
