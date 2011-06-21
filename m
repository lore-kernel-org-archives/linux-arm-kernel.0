From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 21 Jun 2011 01:09:12 -0400
Subject: [PATCH 1/4] ARM: zImage: ensure it is always a multiple of 64 bits in
	size
In-Reply-To: <1308632955-11070-1-git-send-email-nico@fluxnic.net>
References: <1308632955-11070-1-git-send-email-nico@fluxnic.net>
Message-ID: <1308632955-11070-2-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

This is needed for proper alignment when the DTB appending feature
is used.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Acked-by: Tony Lindgren <tony@atomide.com>
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
