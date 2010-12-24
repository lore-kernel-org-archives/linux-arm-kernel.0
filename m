From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Dec 2010 10:06:43 +0000
Subject: [PATCH 02/11] ARM: PL08x: constify vendor name field
In-Reply-To: <20101224100550.GB20587@n2100.arm.linux.org.uk>
References: <20101224100550.GB20587@n2100.arm.linux.org.uk>
Message-ID: <E1PW4Xr-0006DK-Dk@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's a string which we should never overwrite.  So make it const.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 3da49ed..14c024f 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -89,7 +89,7 @@
  * or not.
  */
 struct vendor_data {
-	char *name;
+	const char *name;
 	u8 channels;
 	bool dualmaster;
 };
-- 
1.6.2.5
