From: msalter@redhat.com (Mark Salter)
Date: Tue, 17 Dec 2013 10:48:45 -0500
Subject: [PATCH v2 02/10] arm: select ARCH_MIGHT_HAVE_PC_SERIO
In-Reply-To: <1387295333-24684-1-git-send-email-msalter@redhat.com>
References: <1387295333-24684-1-git-send-email-msalter@redhat.com>
Message-ID: <1387295333-24684-3-git-send-email-msalter@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Architectures which might use an i8042 for serial IO to keyboard,
mouse, etc should select ARCH_MIGHT_HAVE_PC_SERIO.

Signed-off-by: Mark Salter <msalter@redhat.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-footbridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index 0f2111a..d0fb921 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -85,6 +85,7 @@ config FOOTBRIDGE
 # Footbridge in host mode
 config FOOTBRIDGE_HOST
 	bool
+        select ARCH_MIGHT_HAVE_PC_SERIO
 
 # Footbridge in addin mode
 config FOOTBRIDGE_ADDIN
-- 
1.8.3.1
