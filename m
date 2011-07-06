From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 06 Jul 2011 11:24:30 +0100
Subject: [PATCH 5/7] ARM: vmlinux.lds: remove .rodata/.rodata1 from main
	.text segment
In-Reply-To: <20110706102245.GO8286@n2100.arm.linux.org.uk>
References: <20110706102245.GO8286@n2100.arm.linux.org.uk>
Message-ID: <E1QePHS-0004zr-KK@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RODATA() already handles these sections, so allow it to take care
of them for us.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/vmlinux.lds.S |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index c8bb9b7..fa812d0 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -136,8 +136,6 @@ SECTIONS
 			*(.fixup)
 #endif
 			*(.gnu.warning)
-			*(.rodata)
-			*(.rodata.*)
 			*(.glue_7)
 			*(.glue_7t)
 		. = ALIGN(4);
-- 
1.7.4.4
