From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Wed, 09 Jul 2014 15:30:10 +0400
Subject: [RFC/PATCH RESEND -next 16/21] arm: boot: compressed: disable kasan's
 instrumentation
In-Reply-To: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <1404905415-9046-17-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid build errors, compiler's instrumentation used for kernel
address sanitizer, must be disabled for code not linked with kernel.

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 arch/arm/boot/compressed/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 76a50ec..03f2976 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -4,6 +4,8 @@
 # create a compressed vmlinuz image from the original vmlinux
 #
 
+KASAN_SANITIZE := n
+
 OBJS		=
 
 # Ensure that MMCIF loader code appears early in the image
-- 
1.8.5.5
