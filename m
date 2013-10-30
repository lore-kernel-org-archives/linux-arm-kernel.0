From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 30 Oct 2013 17:55:10 +0100
Subject: [PATCH 2/2] ARM: kirkwood: enable HIGHMEM in defconfig
In-Reply-To: <1383152110-19577-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1383152110-19577-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1383152110-19577-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kirkwood-based OpenBlocks A7 platform has 1 GB of memory. To make
use of this memory completely, enabling HIGHMEM is needed, so we
enable it by default in the kirkwood_defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/kirkwood_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 0ae0eaeb..2e762d9 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -27,6 +27,7 @@ CONFIG_PCI_MVEBU=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
+CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CPU_FREQ=y
-- 
1.8.1.2
