From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 28 Sep 2011 16:48:06 +0100
Subject: [PATCH] arm: Add VIRTUALIZATION configuration menu and virtio options
Message-ID: <1317224886-3925-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds menuconfig VIRTUALIZATION to arm Kconfig
and includes virtio Kconfig in it.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/Kconfig |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3269576..426f330 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2101,4 +2101,20 @@ source "security/Kconfig"
 
 source "crypto/Kconfig"
 
+menuconfig VIRTUALIZATION
+	bool "Virtualization"
+	default n
+	---help---
+	  Say Y here to get to see options for using your Linux host to run other
+	  operating systems inside virtual machines (guests).
+	  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if VIRTUALIZATION
+
+source drivers/virtio/Kconfig
+
+endif # VIRTUALIZATION
+
 source "lib/Kconfig"
-- 
1.6.3.3
