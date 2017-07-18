From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 18 Jul 2017 16:26:25 +0200
Subject: [PATCH v2 1/3] ARM: Add definition for monitor mode
In-Reply-To: <1500387987-9240-1-git-send-email-geert+renesas@glider.be>
References: <1500387987-9240-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1500387987-9240-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<asm/ptrace.h> provides *_MODE definitions for the various processor
modes, but monitor mode was missing.

Add MON_MODE to avoid code using the hardcoded value.

Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
ARM maintainers: Please provide your ack, as this is a dependency for a
mach-shmobile patch.

v2:
  - New.
---
 arch/arm/include/uapi/asm/ptrace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/uapi/asm/ptrace.h b/arch/arm/include/uapi/asm/ptrace.h
index 5af0ed1b825a2aa9..70ff6bf489f31193 100644
--- a/arch/arm/include/uapi/asm/ptrace.h
+++ b/arch/arm/include/uapi/asm/ptrace.h
@@ -53,6 +53,7 @@
 #endif
 #define FIQ_MODE	0x00000011
 #define IRQ_MODE	0x00000012
+#define MON_MODE	0x00000016
 #define ABT_MODE	0x00000017
 #define HYP_MODE	0x0000001a
 #define UND_MODE	0x0000001b
-- 
2.7.4
