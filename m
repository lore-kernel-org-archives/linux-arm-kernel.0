From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 12 Jun 2011 02:06:38 -0400
Subject: [PATCH 1/3] ARM: zImage: ensure it is always a multiple of 64 bits in
	size
In-Reply-To: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1307858800-16712-2-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed for proper alignment when the DTB appending feature
is used.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/boot/compressed/vmlinux.lds.in |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/compressed/vmlinux.lds.in b/arch/arm/boot/compressed/vmlinux.lds.in
index ea80abe..6c02db1 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.in
+++ b/arch/arm/boot/compressed/vmlinux.lds.in
@@ -47,6 +47,9 @@ SECTIONS
   .got			: { *(.got) }
   _got_end = .;
   .got.plt		: { *(.got.plt) }
+
+  /* ensure the zImage file size is always a multiple of 64 bits */
+  .pad			: { BYTE(0); . = ALIGN(8); }
   _edata = .;
 
   . = BSS_START;
-- 
1.7.4
