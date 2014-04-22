From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 22 Apr 2014 23:26:05 +0200
Subject: [PATCH v2 01/38] ARM: orion5x: fix target ID for crypto SRAM window
In-Reply-To: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1398202002-28530-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 4ca2c04085a1caa903e92a5fc0da25362150aac2 ('ARM: orion5x:
Move to ID based window creation'), the mach-orion5x code was changed
to use the new mvebu-mbus API. However, in the process, a mistake was
made on the crypto SRAM window target ID: it should have been 0x9
(verified in the datasheet) and not 0x0.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: stable at vger.kernel.org
---
This should be backported to stable all the way to v3.12.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-orion5x/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
index f565f99..7548db2 100644
--- a/arch/arm/mach-orion5x/common.h
+++ b/arch/arm/mach-orion5x/common.h
@@ -21,7 +21,7 @@ struct mv_sata_platform_data;
 #define ORION_MBUS_DEVBUS_BOOT_ATTR   0x0f
 #define ORION_MBUS_DEVBUS_TARGET(cs)  0x01
 #define ORION_MBUS_DEVBUS_ATTR(cs)    (~(1 << cs))
-#define ORION_MBUS_SRAM_TARGET        0x00
+#define ORION_MBUS_SRAM_TARGET        0x09
 #define ORION_MBUS_SRAM_ATTR          0x00
 
 /*
-- 
1.9.2
