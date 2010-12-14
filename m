From: horms@verge.net.au (Simon Horman)
Date: Tue, 14 Dec 2010 12:49:20 +0900
Subject: [PATCH] ARM: mach-shmobile: SCIF port for earlyprintk when using zboot
Message-ID: <1292298560-31329-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialise the SCIF serial port to allow earlyprintk
output when using zboot.

This patch requires the following patches which are going through
Russell King's tree.

* ARM: 6514/1: mach-shmobile: Add zboot support for SuperH Mobile ARM
* ARM: 6515/1: Add zboot support for SuperH Mobile ARM

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 .../arm/mach-shmobile/include/mach/head-ap4evb.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/head-ap4evb.txt b/arch/arm/mach-shmobile/include/mach/head-ap4evb.txt
index e3ebfa7..efd3687 100644
--- a/arch/arm/mach-shmobile/include/mach/head-ap4evb.txt
+++ b/arch/arm/mach-shmobile/include/mach/head-ap4evb.txt
@@ -85,3 +85,10 @@ ED 0xE6150004, 0x80331050
 WAIT 1, 0xFE40009C
 
 ED 0xE6150354, 0x00000002
+
+LIST "SCIF0 - Serial port for earlyprintk"
+EB 0xE6053098, 0x11
+EB 0xE6053098, 0xe1
+EW 0xE6C40000, 0x0000
+EB 0xE6C40004, 0x19
+EW 0xE6C40008, 0x3000
-- 
1.7.2.3
